# ============================================================
# Velveteen Defense Suite
# Phase: 1 - Baseline (Non-destructive)
# Module: Environment Baseline Snapshot
#
# Execution Model:
# - Preferred: Copy and paste directly into PowerShell
# - Alternative: Save and run as .ps1 in a trusted environment
#
# Output:
# - Generates a single temporary .txt report
# - Automatically opens in Notepad
#
# Output Handling:
# - Save output outside the investigated system (USB, trusted machine, or cloud)
# - Do not rely on the local system for long-term storage
# ============================================================

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outFile = Join-Path $env:TEMP "Velveteen_Baseline_$timestamp.txt"

if (Test-Path $outFile) {
    Remove-Item $outFile -Force -ErrorAction SilentlyContinue
}
New-Item -ItemType File -Path $outFile -Force | Out-Null

function Write-Section {
    param([string]$Title)
@"

==============================
$Title
==============================

"@ | Out-File $outFile -Append -Encoding UTF8
}

function Log {
    param([string]$Message)
    $Message | Out-File $outFile -Append -Encoding UTF8
}

$notes = New-Object System.Collections.Generic.List[string]
$review = New-Object System.Collections.Generic.List[string]
$flags = New-Object System.Collections.Generic.List[string]

Log "VELVETEEN BASELINE SNAPSHOT"
Log "Timestamp: $(Get-Date)"
Log "User: $env:USERNAME"
Log "Host: $env:COMPUTERNAME"

Write-Section "SYSTEM INFO"
try {
    $os = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
    Log "OS: $($os.Caption)"
    Log "Version: $($os.Version)"
    Log "Build: $($os.BuildNumber)"
    Log "Last Boot: $($os.LastBootUpTime)"
} catch {
    Log "[FLAG] Failed to retrieve OS information"
    $flags.Add("Could not retrieve OS information")
}

Write-Section "TIME SETTINGS"
try {
    $tz = Get-TimeZone -ErrorAction Stop
    Log "Timezone: $($tz.Id)"
    Log "Local Time: $(Get-Date)"
} catch {
    Log "[FLAG] Failed to retrieve time settings"
    $flags.Add("Could not retrieve time settings")
}

Write-Section "NETWORK ADAPTERS"
try {
    $adapters = Get-NetAdapter -ErrorAction Stop | Where-Object { $_.Status -eq "Up" }
    if (-not $adapters) {
        Log "[REVIEW] No active network adapters detected"
        $review.Add("No active network adapters detected")
    } else {
        foreach ($adapter in $adapters) {
            Log "Adapter: $($adapter.Name) | Status: $($adapter.Status) | MAC: $($adapter.MacAddress)"
        }
    }
} catch {
    Log "[FLAG] Failed to retrieve network adapters"
    $flags.Add("Could not retrieve network adapters")
}

Write-Section "IP CONFIGURATION"
try {
    $configs = Get-NetIPConfiguration -ErrorAction Stop
    foreach ($cfg in $configs) {
        $dnsList = @($cfg.DNSServer.ServerAddresses | Where-Object { $_ }) | Select-Object -Unique

        Log "Interface: $($cfg.InterfaceAlias)"
        Log "  IPv4: $($cfg.IPv4Address.IPAddress)"
        Log "  Gateway: $($cfg.IPv4DefaultGateway.NextHop)"
        Log "  DNS: $($dnsList -join ', ')"

        $hasPublicIPv4 = $false
        foreach ($dns in $dnsList) {
            if ($dns -match '^\d{1,3}(\.\d{1,3}){3}$' -and
                $dns -notmatch '^127\.' -and
                $dns -notmatch '^10\.' -and
                $dns -notmatch '^192\.168\.' -and
                $dns -notmatch '^172\.(1[6-9]|2[0-9]|3[0-1])\.') {
                $hasPublicIPv4 = $true
            }
        }

        if ($hasPublicIPv4) {
            $notes.Add("Public/ISP DNS in use on $($cfg.InterfaceAlias)")
        }

        if (-not $cfg.IPv4DefaultGateway.NextHop -and $cfg.IPv4Address.IPAddress) {
            $review.Add("Interface $($cfg.InterfaceAlias) has IPv4 but no default gateway")
        }
    }
} catch {
    Log "[FLAG] Failed to retrieve IP configuration"
    $flags.Add("Could not retrieve IP configuration")
}

Write-Section "PROXY SETTINGS"
try {
    $proxy = netsh winhttp show proxy | Out-String
    Log $proxy.Trim()

    if ($proxy -notmatch "Direct access") {
        $review.Add("WinHTTP proxy is enabled")
    } else {
        $notes.Add("No WinHTTP proxy configured")
    }
} catch {
    Log "[FLAG] Failed to retrieve WinHTTP proxy settings"
    $flags.Add("Could not retrieve WinHTTP proxy settings")
}

Write-Section "HOSTS FILE"
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"
try {
    if (Test-Path $hostsPath) {
        $rawHosts = Get-Content $hostsPath -ErrorAction Stop
        $meaningfulHosts = $rawHosts | Where-Object {
            $_.Trim() -and $_ -notmatch '^\s*#'
        }

        if (-not $meaningfulHosts) {
            Log "[INFO] No custom hosts file entries detected"
            $notes.Add("Hosts file appears default or comment-only")
        } else {
            foreach ($line in $meaningfulHosts) {
                Log $line
            }
            $review.Add("Hosts file contains active non-comment entries")
        }
    } else {
        Log "[FLAG] Hosts file not found"
        $flags.Add("Hosts file not found")
    }
} catch {
    Log "[FLAG] Failed to read hosts file"
    $flags.Add("Could not read hosts file")
}

Write-Section "LOGGED-IN USERS"
try {
    query user 2>&1 | ForEach-Object { Log $_.ToString() }
} catch {
    Log "[REVIEW] Unable to query logged-in users"
    $review.Add("Could not query logged-in users")
}

Write-Section "LOCAL ADMINS"
try {
    $adminOutput = net localgroup administrators 2>&1
    $adminOutput | ForEach-Object { Log $_.ToString() }
} catch {
    Log "[REVIEW] Unable to list local administrators"
    $review.Add("Could not list local administrators")
}

Write-Section "NOTES"
if ($notes.Count -eq 0) {
    Log "No informational notes"
} else {
    $notes | Sort-Object -Unique | ForEach-Object { Log "[NOTE] $_" }
}

Write-Section "REVIEW ITEMS"
if ($review.Count -eq 0) {
    Log "No immediate review items"
} else {
    $review | Sort-Object -Unique | ForEach-Object { Log "[REVIEW] $_" }
}

Write-Section "FLAGS"
if ($flags.Count -eq 0) {
    Log "No immediate flags"
} else {
    $flags | Sort-Object -Unique | ForEach-Object { Log "[FLAG] $_" }
}

Write-Section "END OF REPORT"
Log "Temporary report opened in Notepad."
Log "If you want to keep it, save a copy outside the investigated system."

Start-Process notepad.exe $outFile
