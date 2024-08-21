$TenantAdminURL = "https://org-admin.sharepoint.com"

#Credentials for PnPOnline
$AdminUserName = "admin@email.com"
$SecurePassword = Get-Content "encrypted/password/file/path" | ConvertTo-SecureString
$Credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $AdminUserName, $SecurePassword

Connect-PnPOnline -Url $TenantAdminURL -Credentials $Credential

$CSSStyle = "<style>
table {font-family: Arial, Helvetica, sans-serif; border-collapse: collapse; width: 100%;}
table td, th {border: 1px solid #ddd; padding: 8px;}
table tr:nth-child(even){background-color: #f2f2f2;}
table tr:hover {background-color: #ddd;}
table th { padding-top: 12px; padding-bottom: 12px; text-align: left; background-color: #4CAF50; color: white;}
</style>"

$EmailTo = "email@email.com"
$subject = "AzureAD Disabled Accounts Report"

#Credentials for ADWS 
$AdminUserName2 = "admin@email.com"
$SecurePassword2 = Get-Content "encrypted/password/file/path" | ConvertTo-SecureString
$Credential2 = new-object -typename System.Management.Automation.PSCredential -argumentlist $AdminUserName2, $SecurePassword2


[string]$body = Get-ADUser -Server server.com -Credential $Credential2 -Filter {(Enabled -eq $False)} -Properties Name, EmailAddress, Enabled |
    Select-Object @{Label="Name";Expression={$_.Name}},
                  @{Label="Email";Expression={$_.EmailAddress}},
                  @{Label="Enabled";Expression={$_.Enabled}} | 
ConvertTo-Html -Title "Disabled Users Report" -Head $CSSStyle -PreContent "Disabled Users Report"
Send-PnPMail -To $EmailTo -Subject $subject -Body $body