# Install Microsoft Graph module
# Install-Module -Name Microsoft.Graph -Scope CurrentUser

# Import Microsoft Graph Users module
Import-Module Microsoft.Graph.Users

# Connect to Microsoft Graph
Connect-MgGraph

# Set Azure AD user to disabled
Update-MgUser -UserId "name@domain.com" -AccountEnabled:$false # Set Azure AD enabled/disabled
