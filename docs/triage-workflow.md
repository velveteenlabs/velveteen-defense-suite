# Triage Workflow

Purpose

Define how to evaluate a system and determine whether a full forensic investigation is required.

When to Use

Use immediately upon receiving a system suspected of compromise.

Triage Objectives
Identify high-level indicators of compromise
Determine risk level
Decide whether to initiate evidence preservation
Triage Process
Run initial triage modules
Review for indicators such as:
unexpected outbound connections
unknown or suspicious processes
signs of persistence (tasks, autoruns, WMI)
Classify system state:
No indicators → continue monitoring
Weak indicators → proceed cautiously, increase visibility
Strong indicators → treat system as compromised
Decision Point

If strong indicators are present:

Stop non-essential interaction
Proceed to Phase 03 (Preservation)
Begin structured evidence collection
Notes

Triage is a classification step, not a conclusion.
The goal is to determine investigative direction, not to prove compromise.
