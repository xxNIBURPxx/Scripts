# Install MS graph and import
# Install-Module Microsoft.Graph
# Import-Module Microsoft.Graph

# Connect to MS graph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Define the group name and description
$groupName = "M365 Test group"
$groupDescription = "This group dynamically includes users based on their office location"
$officeLocation = "LAS"  # Set the specific location you want to filter

# Define the dynamic membership rule
$dynamicRule = "(user.officeLocation -eq `"$officeLocation`")"

# Create the dynamic Microsoft 365 group
$group = New-MgGroup -DisplayName $groupName -Description $groupDescription `
     -MailEnabled: $true -MailNickname "DynamicOfficeGroup" `
     -SecurityEnabled: $false -GroupTypes "Unified" `
     -MembershipRule $dynamicRule `
     -MembershipRuleProcessingState "On"

Write-Host "Dynamic M365 Group '$($group.DisplayName)' created successfully."
