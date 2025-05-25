# Install MS Graph if not already installed
# Install-Module -Name Microsoft.Graph -Scope AllUsers

# Import MS Graph module (optional, auto-imports on cmdlet use)
# Import-Module Microsoft.Graph

# Connect to MS Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Create new user
New-MgUser -DisplayName "First Last" ` # Replace with actual name
           -UserPrincipalName "name@domain.com" ` # Replace with actual UPN
           -AccountEnabled:$true ` # Set to $false if you want to create a disabled user
           -MailNickname "name" ` # Replace with actual mail nickname
           -PasswordProfile @{Password = "YourP@ssword123"; ForceChangePasswordNextSignIn = $true} ` # Replace with actual password
           -UsageLocation "US" ` # Replace with actual usage location
           -GivenName "First" ` # Replace with actual first name
           -Surname "Last" # Replace with actual first and last name