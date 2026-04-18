# Velveteen DFIR / CTI Workflow System

A structured, investigation-first digital forensics and cyber threat intelligence (DFIR/CTI) workflow designed to identify, analyze, and document stealth threats, persistence mechanisms, and low-signal malicious behavior with minimal system impact.

---

## Purpose

This repository provides a phase-based investigation framework for:

* Advanced persistence analysis
* Stealth malware detection (RATs, keyloggers, low-noise threats)
* Evidence preservation and chain-of-custody workflows
* Behavioral correlation (process ↔ persistence ↔ network)
* Regrowth detection and validation

---

## Core Philosophy

* Observe first, do not modify early
* Preserve evidence before acting
* Understand attacker behavior before containment
* Validate findings before conclusions

This system prioritizes forensic integrity and investigative clarity over immediate remediation.

---

## Quick Start (First Time Use)

If you are new to this workflow, follow these steps:

### 1. Start at Phase 00 (Initial Triage)

Navigate to:

```id="q1"
phases/phase-00-initial-triage
```

* Run the initial triage script(s)
* Determine if the system shows signs of compromise
* Decide whether to proceed as a full investigation

---

### 2. Begin Baseline Collection

Go to:

```id="q2"
phases/phase-01-baseline
```

* Capture system state (environment, users, firewall, logging)
* This becomes your reference point for later comparison

---

### 3. Run Suspicion Sweeps

Go to:

```id="q3"
phases/phase-02-suspicion
```

Run primary sweeps:

* Connection exposure sweep
* Persistence sweep
* RAT indicator sweep

If anything is flagged:

* Use the corresponding **follow-up modules** in the same phase

---

### 4. Preserve Evidence (Critical Step)

If suspicion is confirmed, move to:

```id="q4"
phases/phase-03-preservation
```

* Initialize case folder
* Capture evidence snapshots
* Perform disk imaging (if required)
* Preserve artifacts before deeper analysis

---

### 5. Perform Deep Analysis

Go to:

```id="q5"
phases/phase-05-analysis
```

* Analyze persistence mechanisms
* Investigate suspicious binaries and artifacts
* Review scheduled tasks, autoruns, WMI, registry

---

### 6. Correlate Findings

Go to:

```id="q6"
phases/phase-06-correlation
```

* Map relationships:

  * Process ↔ persistence
  * Process ↔ network
  * Artifact ↔ execution

---

### 7. Validate and Check for Regrowth

Go to:

```id="q7"
phases/phase-08-validation
```

* Re-run sweeps
* Compare results (diff analysis)
* Identify recurring behavior or persistence

---

### 8. Document and Report

Go to:

```id="q8"
phases/phase-09-reporting
```

* Generate summary of findings
* Build timeline and evidence mapping
* Prepare final report

---

## How to Use This Repository

### Workflow Model

Each phase follows a consistent structure:

* **Primary modules**

  * Broad sweeps or core actions
* **Follow-up modules**

  * Targeted investigation based on findings
* **README guidance**

  * Explains what to run and when

---

### General Usage Pattern

1. Run primary script(s) in a phase
2. Review output
3. If suspicious activity is detected:

   * Run relevant follow-up modules
4. Move to the next phase only when ready

---

### Important Rules

* Do not skip phases early in an investigation
* Do not modify the system before preservation
* Always review outputs before proceeding
* Document actions as you go

---

## Repository Structure

```id="q9"
velveteen-defense-suite/
├── docs/                → Guides, workflows, and standards
├── phases/              → Core investigation phases
├── shared/              → Reusable helpers, templates, and references
├── runners/             → Workflow execution scripts
├── examples/            → Sample outputs and structures
```

---

## Key Features

### Investigation-First Design

* Non-destructive early phases
* Evidence preservation built into workflow
* Minimal system impact

### Behavioral Analysis Focus

* Process ↔ persistence correlation
* Process ↔ network relationships
* Artifact lineage tracking

### Evidence Integrity

* Hashing and artifact tracking
* Chain-of-custody awareness
* Structured evidence organization

### Live Monitoring Support

* Background watchers (process, persistence, network)
* Alert-based investigation triggers
* Wireshark integration guidance

### Validation and Regrowth Detection

* Diff-based analysis
* Recurring persistence detection
* Re-check workflows

---

## What This Is Not

This repository is intentionally not:

* A containment-first toolkit
* A system hardening solution
* An antivirus replacement
* A fully automated detection system

---

## Separation of Concerns

This repository focuses on investigation, analysis, and evidence preservation.

A separate future repository will handle:

* Rapid containment
* Firewall hardening
* Port exposure reduction
* System lockdown

---

## Intended Audience

* DFIR analysts
* CTI practitioners
* Security researchers
* Cybersecurity students
* Behavioral threat analysts

---

## Recommended Workflow Mindset

* Treat the system as potentially compromised
* Assume evidence can be lost if mishandled
* Prioritize understanding over speed
* Validate findings before escalation

---

## Future Development

* Enhanced correlation mapping
* Automated reporting outputs
* Visualization of attacker behavior
* Expanded persistence detection modules

---

## Disclaimer

This repository is intended for:

* Educational use
* Research
* Defensive cybersecurity investigation

Use responsibly and only on systems you are authorized to analyze.

---

## Final Note

This is not just a collection of scripts.

It is a structured investigative system designed to support disciplined, evidence-driven cyber investigations.
