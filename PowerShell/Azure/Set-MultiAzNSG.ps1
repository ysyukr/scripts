<#
    .NOTES
    File Name : Set-MultiAzNSG.ps1
    Version : 0.1
    Author : Yongsu, Yuk
#>
Param (
    [Parameter(Mandatory=$false)] [string]$NSGName = '*',
    [Parameter(Mandatory=$true)] [string]$RuleSet,
    [Parameter(Mandatory=$true)] [string]$RuleName,
    [Parameter(Mandatory=$false)] [string]$Access = 'Allow',
    [Parameter(Mandatory=$false)] [string]$Protocol = '*',
    [Parameter(Mandatory=$false)] [string]$Bound = 'Inbound',
    [Parameter(Mandatory=$true)] [Int32]$Priority,
    [Parameter(Mandatory=$false)] [string]$SourceAddrPrefix = '*',
    [Parameter(Mandatory=$false)] [string]$SourPRange = '*',
    [Parameter(Mandatory=$false)] [string]$DesAddrPrefix = '*',
    [Parameter(Mandatory=$true)] [string]$DesPRange
)

$AzNSGs = Get-AzNetworkSecurityGroup | Where-Object {$_.Name -like $NSGName}

$AzNSG = @()

if($RuleSet -eq "Add") {
    foreach ($AzNSG in $AzNSGs) {
        try{
            $AzNSG | Add-AzNetworkSecurityRuleConfig `
            -Name $RuleName `
            -Access $Access `
            -Protocol $Protocol `
            -Direction $Bound `
            -Priority $Priority `
            -SourceAddressPrefix $SourceAddrPrefix `
            -SourcePortRange $SourPRange `
            -DestinationAddressPrefix $DesAddrPrefix `
            -DestinationPortRange $DesPRange

            $AzNSG | Set-AzNetworkSecurityGroup
        }
        catch
        {
            echo $('Line ' + $_.InvocationInfo.ScriptLineNumber + ' : ' + $_.Exception.Message)
        }
    }
}
else {
    foreach ($AzNSG in $AzNSGs) {
        try {
            $AzNSG | Remove-AzNetworkSecurityRuleConfig `
            -Name $RuleName
            
            $AzNSG | Set-AzNetworkSecurityGroup
        }
        catch
        {
            echo $('Line ' + $_.InvocationInfo.ScriptLineNumber + ' : ' + $_.Exception.Message)
        }
    }
}