<#
.SYNOPSIS
    Manage Microsoft Entra ID MFA resets from a single script.
.DESCRIPTION
    This script provides a menu with options to:
      1. Force a user to re-register MFA
      2. Revoke MFA sessions
      3. Remove a specific MFA method
    It uses Microsoft Graph PowerShell SDK.
.AUTHOR
    Shannon Eldridge-Kuehn
.DATE
    2025-09-24
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName
)

function Show-Menu {
    Write-Host "Select an MFA reset action for $UserPrincipalName:"
    Write-Host "1. Force re-register MFA (clear all methods)"
    Write-Host "2. Revoke MFA sessions (force MFA prompt again)"
    Write-Host "3. Remove a specific MFA method"
    Write-Host "Q. Quit"
}

Connect-MgGraph -Scopes "User.ReadWrite.All","Directory.AccessAsUser.All"

do {
    Show-Menu
    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        "1" {
            Get-MgUserAuthenticationMethod -UserId $UserPrincipalName | ForEach-Object {
                Remove-MgUserAuthenticationMethod -UserId $UserPrincipalName -AuthenticationMethodId $_.Id
            }
            Write-Output "MFA methods cleared for $UserPrincipalName. User will be forced to re-register."
        }
        "2" {
            Revoke-MgUserSignInSession -UserId $UserPrincipalName
            Write-Output "MFA sessions revoked for $UserPrincipalName. User will be prompted for MFA again."
        }
        "3" {
            Write-Output "Listing current authentication methods for $UserPrincipalName..."
            $methods = Get-MgUserAuthenticationMethod -UserId $UserPrincipalName
            $i = 1
            foreach ($m in $methods) {
                Write-Host "$i. $($m.Id) - $($m.AdditionalProperties['phoneType']) $($m.AdditionalProperties['phoneNumber'])"
                $i++
            }
            $methodChoice = Read-Host "Enter the Id of the method to remove"
            Remove-MgUserAuthenticationMethod -UserId $UserPrincipalName -AuthenticationMethodId $methodChoice
            Write-Output "Removed MFA method $methodChoice for $UserPrincipalName."
        }
        "Q" {
            Write-Output "Exiting script."
        }
        default {
            Write-Host "Invalid selection. Try again."
        }
    }
} while ($choice -ne "Q")