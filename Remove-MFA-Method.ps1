<#
.SYNOPSIS
    Remove a specific MFA method for a user in Microsoft Entra ID.
.DESCRIPTION
    This script lists and removes a specific authentication method (such as a phone number or FIDO key)
    for a user in Microsoft Entra ID.
.AUTHOR
    Shannon Eldridge-Kuehn
.DATE
    2025-09-24
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName,

    [Parameter(Mandatory=$true)]
    [string]$MethodId
)

Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.AccessAsUser.All"

Remove-MgUserAuthenticationPhoneMethod -UserId $UserPrincipalName -PhoneAuthenticationMethodId $MethodId

Write-Output "Removed MFA method $MethodId for $UserPrincipalName."