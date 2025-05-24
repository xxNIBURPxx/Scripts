# Script assumes you have the Microsoft Graph PowerShell module installed and connected to your Azure AD tenant.

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Import the CSV file
# CSV formatted as DisplayName,UserPrincipalName,Password,MailNickname
$users = Import-Csv -Path "C:\PathToCSVFile\AAD-Users.csv" # Change to your CSV file path

foreach ($user in $users) {
    $PasswordProfile = @{
        Password = $user.Password
        ForceChangePasswordNextSignIn = $true
    }

    New-MgUser -DisplayName $user.DisplayName `
               -UserPrincipalName $user.UserPrincipalName `
               -AccountEnabled $false `
               -MailNickname $user.MailNickname `
               -PasswordProfile $PasswordProfile
}