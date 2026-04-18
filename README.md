Velveteen Defense Suite
Overview

Velveteen is a workflow-driven Windows host triage and investigation system designed to guide analysts from initial suspicion through evidence preservation, investigation, containment, and validation.

This is not just a collection of scripts.
Velveteen is a decision system built around real-world incident response thinking:

Observe → Preserve → Understand → Then Act

Choose Your Objective First

Before beginning, decide what matters most.

Data Protection (Loss Prevention)

You care most about protecting files and minimizing risk.

Approach:

Run Baseline (Section 1)
Run Rapid Suspicion (Section 2)
If red flags appear, move quickly to Containment

Manual actions:

Save important files externally (USB or trusted system)
Disconnect network if risk escalates

Tradeoff:

Less visibility into attacker behavior
Investigation / CTI (Evidence Gathering)

You want to understand the intrusion and preserve evidence.

Approach:

Follow the workflow step-by-step
Preserve evidence before acting
Avoid early containment unless necessary

Tradeoff:

Slightly higher risk while observing
Balanced Approach (Recommended)
Run Baseline and Suspicion
Immediately perform Evidence Preservation
Then decide whether to investigate further or move to containment
Investigation Flow (High-Level)
Suspicion Trigger
    ↓
Baseline & Environment Integrity
    ↓
Rapid Suspicion & Initial Signal
    ↓
[Red Flags?]
    ↓
Evidence Preservation
    ↓
[Investigation vs Preservation]
    ↓
Recon & Artifact Analysis
    ↓
Containment (if justified)
    ↓
Validation & Re-check
    ↓
Organize & Report

Full workflow: see docs/triage-map.md

How to Use This Suite
Quick Mode
Copy and paste scripts directly into PowerShell
Each tool outputs one .txt file
The file automatically opens in Notepad
Use the output to guide your next step

Designed for:

speed
clarity
low friction under pressure
Full Suite Mode
Follow the workflow step-by-step
Run modules in sequence
Collect outputs into a case folder
Perform deeper analysis and correlation
Critical Rules
If something looks suspicious, capture a snapshot first
Do not destroy what you do not understand
Decide: investigate or preserve, not both at the same time
Hash anything you may need later
Contain only after you have enough context
Caveats and Exceptions
When to Disconnect Immediately

Disconnect from the network only if:

active data exfiltration
ransomware behavior
clear remote control activity
imminent data risk

Otherwise, remain connected briefly to observe behavior.

When to Skip Ahead

You may move directly to containment if:

data protection is your only priority
compromise is obvious
evidence preservation is not required
When to Slow Down

Proceed carefully if:

you suspect a targeted intrusion
you need evidence for reporting or legal use
you want to understand attacker behavior
Evidence vs Visibility Tradeoff
Preserving evidence reduces visibility into live behavior
Observing behavior introduces slight system interaction
Trust Assumptions

If a system is compromised:

logs may be altered
files may be deleted
processes may hide

Treat the system as untrusted for long-term storage and truth.

Repository Structure

Velveteen is organized around the investigation workflow.

modules/
  baseline/
  suspicion/
  preservation/
  recon/
  containment/
  validation/
  reporting/

docs/
  triage-map.md
  decision-workflow.md
  module-catalog.md
How to Use the Modules

Quick usage:

Run individual scripts
Review output
follow the workflow manually

Full usage:

Follow the workflow in order
combine outputs into a case
analyze findings together
Output Design

All tools use plain text output.

Benefits:

works on any Windows system
no external dependencies
opens instantly
easy to copy and share
reliable under compromised conditions

Readable output is prioritized over complex interfaces.

Preserve Your Output

After running any tool:

Save output outside the system
Recommended:
USB or external drive
trusted machine
trusted cloud account

Keep both:

original file
backup copy

Treat the investigated system as untrusted for long-term storage.

How to Move Through the Workflow

Each script helps answer: what should I do next.

After running a tool:

Read the output
Identify anomalies
Follow the next step in the workflow

General guidance:

No anomalies: continue
Anomalies: preserve evidence
High confidence: move to containment
Emergency Snippets

Quick helpers for immediate actions.

Hash a File
Get-FileHash "C:\Path\to\file.exe" -Algorithm SHA256
Preserve a File
$dest = "$env:USERPROFILE\Desktop\Velveteen_Preserve"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item "C:\Path\to\suspicious.exe" $dest -Force
Find Process Path
Get-Process notepad | Select Name, Id, Path
Quick Connections
netstat -ano | findstr ESTABLISHED
Timestamped Note
"$(Get-Date) - Suspicious activity observed" |
Out-File "$env:USERPROFILE\Desktop\Velveteen_Notes.txt" -Append
Design Philosophy

Velveteen tools are:

modular
workflow-aware
readable
safe-first
decision-driven

Each tool is designed to support investigation, not replace judgment.

Final Note

Move fast when protecting data.
Move slow when seeking truth.

Both approaches are valid. The key is choosing intentionally.
