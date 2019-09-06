<#
    .NOTES
    File Name : Get-SMBVolumeCheck.ps1
    Version : 0.1
    Author : Yongsu, Yuk
#>

$pwd = Split-Path -Parent $PSCommandPath;
. "$pwd\conf\PSCre.ps1"

$PSCre_admin = get_ad_admin

$datetime = Get-Date -Format "yyyy-MM-dd HH"

$smb_hosts = Get-ADComputer -Filter 'Name -like "smb-*"'

$results = @()

foreach ($smb_host in $smb_hosts.Name) {
    try {
        $result = Invoke-Command -ComputerName $smb_host -Authentication Credssp -Credential $PSCre_admin -ArgumentList $smb_host -ScriptBlock {
            param (
                [String][Parameter(Mandatory = $true)][ValidateNotNull()] $smb_host
            )
            Get-Volume | Where-Object {$_.FileSystem -like 'CSVFS'}
        }

        $results += $result
        
        }
    catch {
        $result = Write-Output $('Exception occured while invoke-command in ' + $smb_host + ' : ' + $_.Exception.Message);
        $results += $result
    }
}