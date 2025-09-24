# Microsoft Entra ID MFA Reset Tools

This repository contains PowerShell scripts to manage and reset MFA (Multi-Factor Authentication) for users in Microsoft Entra ID.

## Scripts

### Manage-MFA.ps1 (Recommended)
This is the combined script that provides a simple interactive menu for administrators.  
It supports the following options:
1. Force a user to re-register MFA methods (clear all)  
2. Revoke MFA sessions (force MFA prompt again)  
3. Remove a specific MFA method  

**Example usage:**

```powershell
# Run the script with a user principal name
.\Manage-MFA.ps1 -UserPrincipalName user@domain.com

# You will see a menu like this:
Select an MFA reset action for user@domain.com:
1. Force re-register MFA (clear all methods)
2. Revoke MFA sessions (force MFA prompt again)
3. Remove a specific MFA method
Q. Quit

# Enter the number for the action you want to perform
```

### Reset-MFA-ReRegister.ps1
Forces a user to re-register all MFA methods by clearing them.

```powershell
.\Reset-MFA-ReRegister.ps1 -UserPrincipalName user@domain.com
```

### Revoke-MFA-Sessions.ps1
Revokes a user's existing MFA sessions without clearing their registered methods.

```powershell
.\Revoke-MFA-Sessions.ps1 -UserPrincipalName user@domain.com
```

### Remove-MFA-Method.ps1
Removes a specific MFA method by MethodId.

```powershell
.\Remove-MFA-Method.ps1 -UserPrincipalName user@domain.com -MethodId <MethodId>
```

List available MethodIds with:
```powershell
Get-MgUserAuthenticationMethod -UserId user@domain.com
```

## Prerequisites

- PowerShell 7+
- Microsoft Graph PowerShell SDK (`Install-Module Microsoft.Graph`)
- Admin rights in Microsoft Entra ID

## Author
Shannon Kuehn  
Date: 2025-09-24

## License
This project is licensed under the MIT License.