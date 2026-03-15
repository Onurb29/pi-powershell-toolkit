# PI PowerShell Toolkit

PowerShell utilities and connection patterns for working with AVEVA / OSIsoft PI systems using AFSDK.

This repository focuses on practical scripting patterns for:

- PI Data Archive connections
- Asset Framework (AF) connections
- Reading & comparing PI tag values
- Reusable PowerShell helpers for industrial environments

The goal is to document clear and transferable patterns for engineers working with PI systems.

---

## Key Architecture Concept

There are two different server connections in PI environments.

PI Data Archive → used for PI tags  
Asset Framework (AF) → used for Elements, Attributes, Analyses

These are **not the same object**.

PI tags require a PI server connection (`$pi`), not an AF server object (`$af`).

---

## Verify PI Server Connection

After connecting to the PI Data Archive, verify the session with:

```powershell
$pi.ConnectionInfo.IsConnected
```

You can also inspect basic server details with:

```powershell
$pi.Name
$pi.ServerVersion
```

## $pi Object

After running:

```powershell
$pi = Connect-PI -ServerName "PI-SERVER"
```

`$pi` becomes an AFSDK PIServer object.

This object exposes server-level properties and methods used to interact with the PI Data Archive.

The $pi object provides access to:

- Connection information
- Server name
- Server version
- Server time zone
- PI Point search capabilities
- Methods to read snapshot values
- Methods to read recorded values
- Server-level configuration and metadata

### Example usage:

```powershell
$pi.ConnectionInfo.IsConnected
$pi.Name
$pi.ServerVersion

# Searching for a PI tag:
$pt = [OSIsoft.AF.PI.PIPoint]::FindPIPoint($pi, "sinusoid")

## License

MIT License


```