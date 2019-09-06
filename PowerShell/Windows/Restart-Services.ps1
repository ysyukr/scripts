<#
    .NOTES
    File Name : Restart-Services.ps1
    Version : 0.5
    Author : Yongsu, Yuk
#>

Param ( 
[Parameter(Mandatory=$true)] [String]$ServiceName
)

function Restart-Services {
    $ServicePID = (Get-WmiObject -Class win32_service | Where-Object {$_.name -eq $ServiceName}).processID

    Restart-Service -name $ServiceName
    Start-Sleep -Seconds 60

    $getService_chk_1 = Get-Service -name $ServiceName

    if ($getService_chk_1 | Where-Object {$_.Status -eq "StopPending" -or $_.Status -eq "Stopping"}) {
        try {
            Stop-Process -Id $ServicePID -Force -PassThru -ErrorAction Stop
        }
        catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    }

    Start-Sleep -Seconds 5
    $getService_chk_2 = Get-Service -name $ServiceName

    if ($getService_chk_2 | Where-Object {$_.Status -eq "Running"}) {
            Write-Output "$ServiceName Service Restat Success."
        }
    else {
        Start-Service -Name $ServiceName
    }

}

Restart-Services $ServiceName