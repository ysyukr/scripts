<#
    .NOTES
    File Name : Restart-PerformanceCounter.ps1
    Version : 0.3
    Author : Yongsu, Yuk
#>

$VMHosts = Get-SCVMHost | Select-String "host"

foreach ($VMHost in $VMHosts)
{
    try
    {
        echo $("Target VMHost : " + $VMHost)

        $logmanQuery = Invoke-Expression "logman.exe query 'vm monitor' -s $VMHost"
        
        if($result = $logmanQuery -Match "Stopped")
        {
            Invoke-Expression "logman.exe start 'vm monitor' -s $VMHost"
        }
        else
        {
            Invoke-Expression "logman.exe query -s $VMHost"
        }

        echo $result
    }
    catch
    {
        echo $('Line ' + $_.InvocationInfo.ScriptLineNumber + ' : ' + $_.Exception.Message)
    }
}