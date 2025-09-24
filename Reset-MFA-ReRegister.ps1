<#
.SYNOPSIS
    Force a user to re-register MFA in Microsoft Entra ID.
.DESCRIPTION
    This script clears all registered authentication methods for a user in Microsoft Entra ID,
    forcing them to re-register MFA methods at next login.
.AUTHOR
    Shannon Eldridge-Kuehn
.DATE
    2025-09-24
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName
)

Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.AccessAsUser.All"

Get-MgUserAuthenticationMethod -UserId $UserPrincipalName | ForEach-Object {
    Remove-MgUserAuthenticationMethod -UserId $UserPrincipalName -AuthenticationMethodId $_.Id
}

Write-Output "MFA methods cleared for $UserPrincipalName. User will be forced to re-register."