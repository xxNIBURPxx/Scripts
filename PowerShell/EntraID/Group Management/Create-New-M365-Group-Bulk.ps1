# Connect Microsoft Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All", "User.Read.All"

# Define CSV file path - CSV header GroupName,Alias,Description,Owner
$csvPath = "C:\PathToCSVFile\m365-groups.csv" # Change to your CSV file path

# Import CSV
$groups = Import-Csv -Path $csvPath

# Loop through each row and create a Microsoft 365 Group
foreach ($group in $groups) {
    try {
        # Extract details
        $displayName = $group.GroupName
        $mailNickname = $group.Alias
        $description = $group.Description
        $ownerEmail = $group.Owner

        # Get the owner's user ID
        $owner = Get-MgUser -Filter "mail eq '$ownerEmail'"
        if (-not $owner) {
            Write-Host "Owner $ownerEmail not found. Skipping group: $displayName" -ForegroundColor Red
            continue
        }

        # Create the Microsoft 365 Group
        $newGroup = New-MgGroup -DisplayName $displayName -MailEnabled:$true -MailNickname $mailNickname `
            -SecurityEnabled: $false -GroupTypes "Unified" -Description $description -IsAssignableToRole: $false

        # Add Owner to the Group
        New-MgGroupOwner -GroupId $newGroup.Id -DirectoryObjectId $owner.Id
        Write-Host "Successfully created group: $displayName with owner $ownerEmail" -ForegroundColor Green
    }
    catch {
        Write-Host "Error creating group: $displayName - $_" -ForegroundColor Red
    }
}

 