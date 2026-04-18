# Environment Baseline Snapshot

Phase: 1 - Baseline (Non-destructive)

## Purpose
Establish system environment and configuration state before deeper triage, investigation, or containment.

This module helps answer:
- What is this system?
- How is it configured?
- Are there environment-level review items before deeper analysis?

## What It Checks
- Operating system and uptime
- Timezone and system time
- Active network adapters
- IP configuration
- DNS servers
- WinHTTP proxy settings
- Hosts file contents
- Logged-in users
- Local administrators

## Execution
- Preferred: copy and paste directly into PowerShell
- Alternative: run as a `.ps1` file in a trusted environment

## Output
- Generates a temporary `.txt` report
- Automatically opens in Notepad
- Does not save permanently unless you choose to save it

## Output Sections
- Notes
- Review Items
- Flags

## When to Use
Run this first in any investigation workflow.

## Why It Matters
This establishes baseline environment truth before:
- deeper scans
- persistence review
- network triage
- containment actions

## Notes
- Public/ISP DNS is common and not automatically suspicious
- Default or comment-only hosts files are common
- This module does not modify system state
