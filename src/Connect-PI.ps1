<#
.SYNOPSIS
Connects to a PI Data Archive server using AFSDK.

.DESCRIPTION
Loads the OSIsoft AFSDK assembly and connects to the specified
PI Data Archive server. Returns a PIServer object that can be used
to query PI Points, snapshots, recorded values, and other server-level data.

.PARAMETER ServerName
Name of the PI Data Archive server.

.PARAMETER AFSDKPath
Optional explicit path to OSIsoft.AFSDK.dll.

.EXAMPLE
$pi = Connect-PI -ServerName "PI-SERVER"

.EXAMPLE
$pi = Connect-PI -ServerName "PI-SERVER" -AFSDKPath "C:\\Program Files (x86)\\PIPC\\AF\\PublicAssemblies\\4.0\\OSIsoft.AFSDK.dll"
#>

function Connect-PI {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [string]$ServerName = "PI-SERVER",

        [Parameter(Mandatory = $false)]
        [string]$AFSDKPath = "C:\\Program Files (x86)\\PIPC\\AF\\PublicAssemblies\\4.0\\OSIsoft.AFSDK.dll"
    )

    try {
        if (-not ("OSIsoft.AF.PI.PIServers" -as [type])) {
            if (Test-Path $AFSDKPath) {
                Add-Type -Path $AFSDKPath
                Write-Host "Loaded OSIsoft.AFSDK from: $AFSDKPath" -ForegroundColor DarkGray
            }
            else {
                throw "AFSDK assembly not found at path: $AFSDKPath"
            }
        }

        $piSystems = New-Object OSIsoft.AF.PI.PIServers
        $pi = $piSystems[$ServerName]

        if (-not $pi) {
            throw "PI server '$ServerName' was not found."
        }

        $pi.Connect()

        if ($pi.ConnectionInfo.IsConnected) {
            Write-Host "Connected to PI server: $($pi.Name)" -ForegroundColor Green
        }
        else {
            throw "Connection failed to PI server '$ServerName'."
        }

        return $pi
    }
    catch {
        throw "Connect-PI failed: $($_.Exception.Message)"
    }
}
