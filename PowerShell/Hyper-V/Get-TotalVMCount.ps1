<#
    .NOTES
    File Name : Get-TotalVMCount.ps1
    Version : 0.1
    Author : Yongsu, Yuk
#>

$datetime = Get-Date -Format "yyyy-MM-dd HH"

$Clusters = 'host*'

$VMs = @()
foreach ($Cluster in $Clusters) {
    try {
        $VMs = Get-SCVirtualMachine | Where-Object {$_.VMHost -like $Cluster}
        $cluster_name_replace = $Cluster -creplace 'host\*','1'
        $vm_Total = $VMs.Count
        $vm_vCore = ($VMs | Measure-Object CPUCount -sum).sum

        }
        catch {
           Write-Output $('Exception occured while invoke-command in ' + $VM + ' : ' + $_.Exception.Message);
        }
}