<#
    .NOTES
    File Name : Get-VMHostMemoryCheck.ps1
    Version : 0.1
    Author : Yongsu, Yuk
#>

$datetime = Get-Date -Format "yyyy-MM-dd HH"

$VMHosts = Get-SCVMHost

foreach ($VMHost in $VMhosts) {
    try {
    $vmh_name_replace = $VMHost.ComputerName `
    -creplace 'host-v01','1'

    $vmh_mem_free = ('{0:N1}' -f($VMHost.AvailableMemory/1024))
    $vmh_cpu_using = $VMhost.CpuUtilization

    }
    catch {
       Write-Output $('Exception occured while invoke-command in ' + $VMHost + ' : ' + $_.Exception.Message);
    }
}