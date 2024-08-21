# AzureAD_Disabled_Accounts

**Prerequisites**
Active Directory Web Services (ADWS) must be installed and running

To Install in PowerShell (must run as administrator):
```
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online
```

**YOUR changes in the script:**

    1) Fill in the values for:
              a) $TenantAdminURL 
              b) $EmailTo 
              c) -Server ADWSServer.com
              d) Credentials for PnPOnline (SharePoint credentials)
              e) Credentials for ADWS (your ADWSServer.com credentials)
    2) Fill/Change $subject, $body

**To Find your ADWS**
```
set user
nslookup
```


**To Store Password elsewhere:**
```
# Convert the plain text password to a secure string
$securePassword = ConvertTo-SecureString "YourPlainPassword" -AsPlainText -Force

# Convert the secure string to an encrypted standard string and save it to a file
$securePassword | ConvertFrom-SecureString | Out-File "C:\path\to\password.txt"
```


**Automate Running Script in set time interval (Windows):**

    1) Open Task Scheduler
    2) Click Create Basic Task on right side of screen
    3) Put Name and Description
    4) Choose when you want task to run
    5) Select Start a program
    6) In Program/Script: type powershell or copy the path of the powershell there
    7) In Add arguments (optional): type "& ""path of script"""
    8) Leave Start in (optional) blank
    9) You can test it as well by clicking on the task and clicking Run
