<#
.SYNOPSIS
    Revoke MFA sessions for a user in Microsoft Entra ID.
.DESCRIPTION
    This script revokes refresh tokens and forces a user to reauthenticate with MFA
    without clearing registered methods.
.AUTHOR
    Shannon Kuehn
.DATE
    2025-09-24
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName
)

Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.AccessAsUser.All"

Revoke-MgUserSignInSession -UserId $UserPrincipalName

Write-Output "MFA sessions revoked for $UserPrincipalName. User will be prompted for MFA again."