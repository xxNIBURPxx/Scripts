# Install MS Graph
# Install-Module Microsoft.Graph -AllowClobber

# Connect MS Graph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

# Import the CSV file
$groups = Import-Csv -Path "C:\PathToCSVFile\AAD-Groups.csv" # Change to your CSV file path

# Loop through each row in the CSV and create a new group
foreach ($group in $groups) {
    # Convert MailEnabled and SecurityEnabled to booleans
#    $MailEnabled = $group.MailEnabled -eq "False"  # Should be False as per your case
#    $SecurityEnabled = $group.SecurityEnabled -eq "True"  # Should be True as per your case

    # Since SecurityEnabled is true, set GroupTypes to empty array for security groups
    $GroupTypes = @()

    # Create the new security group
    New-MgGroup -DisplayName $group.DisplayName `
                -MailNickname $group.MailNickname `
                -Description $group.Description `
                -MailEnabled: $false `
                -SecurityEnabled: $true `
                -GroupTypes $GroupTypes
}
