# PI PowerShell Toolkit

PowerShell utilities and connection patterns for working with
AVEVA / OSIsoft PI systems using AFSDK.

This repository focuses on practical scripting patterns for:

• PI Data Archive connections  
• Asset Framework (AF) connections  
• Reading & comparing  PI tag values  
• Reusable PowerShell helpers for industrial environments  

The goal is to document clear and transferable patterns for engineers
working with PI systems.

---

## Key Architecture Concept

There are two different server connections in PI environments.

PI Data Archive → used for PI tags  
Asset Framework (AF) → used for Elements, Attributes, Analyses

These are **not the same object**.

PI tags require a PI server connection (`$pi`), not an AF server object (`$af`).

---

## Verify PI Server Connection
