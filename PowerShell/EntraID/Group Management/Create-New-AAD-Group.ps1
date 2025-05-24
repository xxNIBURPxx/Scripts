# This script assumes you have the Microsoft Graph PowerShell SDK
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Create new Azure AD group
New-MgGroup -DisplayName "Test group" `
            -MailEnabled $false `
            -SecurityEnabled $true `
            -MailNickname "testgroup" `
            -Description "This is a test group."