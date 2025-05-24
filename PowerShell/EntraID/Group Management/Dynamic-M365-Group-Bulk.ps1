# Import the Microsoft.Graph module if not already installed
Install-Module -Name Microsoft.Graph -AllowClobber

# Connect to Microsoft Graph (with the necessary permissions)
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Import the CSV file with group information
$groups = Import-Csv -Path "C:\PathToCSVFile\M365-Groups.csv" # Change to your CSV file path

# Loop through each group in the CSV file and create the M365 group
# Format of csv DisplayName,MailNickname,Description,OfficeLocation
foreach ($group in $groups) {

    # Set dynamic membership rule query based on OfficeLocation
    $dynamicRule = "((user.officeLocation -eq `"" + $group.OfficeLocation + "`"))"

    # Create the M365 group (Unified group type) with dynamic membership
    $newGroup = New-MgGroup -DisplayName $group.DisplayName `
                            -MailNickname $group.MailNickname `
                            -Description $group.Description `
                            -MailEnabled $true `
                            -SecurityEnabled $false `
                            -GroupTypes @("Unified") `
                            -MembershipRule $dynamicRule `
                            -MembershipRuleProcessingState "On" `
                            -AssignableToRole $false

    # Output the created group details
    Write-Host "Created group: $($newGroup.DisplayName) with dynamic membership rule for office location: $($group.OfficeLocation)"
}

# Disconnect from Microsoft Graph
# Disconnect-MgGraph
