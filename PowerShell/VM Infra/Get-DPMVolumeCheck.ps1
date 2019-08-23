<#
    .NOTES
    File Name : Get-DPMHostVolumeUsing.ps1
    Version : 0.1
    Author : Yongsu, Yuk
#>

$pwd = Split-Path -Parent $PSCommandPath;
. "$pwd\conf\PSCre.ps1"

$PSCre_admin = get_ad_admin

$datetime = Get-Date -Format "yyyy-MM-dd HH"

$dpm_hosts = Get-ADComputer -Filter 'Name -like "dpm*"'

$results = @()

foreach ($dpm_host in $dpm_hosts.Name) {
    try {
        $result = Invoke-Command -ComputerName $dpm_host -Authentication Credssp -Credential $PSCre_admin -ArgumentList $dpm_host -ScriptBlock {
            param (
                [String][Parameter(Mandatory = $true)][ValidateNotNull()] $dpm_host
            )
            Get-DPMDisk -DPMServerName $dpm_host
        }
        
        $results += $result

        }
    catch {
        $result = Write-Output $('Exception occured while invoke-command in ' + $dpm_host + ' : ' + $_.Exception.Message);
        $results += $result
    }
}