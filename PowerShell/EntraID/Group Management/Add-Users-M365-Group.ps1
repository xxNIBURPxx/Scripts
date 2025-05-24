 # Connect to Microsoft 365
 Connect-MgGraph -Scopes GroupMember.ReadWrite.All

 # Define variables 
 $csvPath = "C:\PathToCSVFile\M365-Users.csv"  # Change this to your CSV file path - Header UserPrincipalName
 
 # Import CSV
 $groups = Import-Csv -Path $csvPath
 
 foreach ($group in $groups) {
     $groupId = $group.GroupId  # Assuming CSV has a column named 'GroupId'
     $userUPNs = $group.UserPrincipalNames -split ";"  # Assuming CSV has a column named 'UserPrincipalNames' with UPNs separated by semicolons
     foreach ($userUPN in $userUPNs) {

         # Get user ID from UPN
         $userId = (Get-MgUser -Filter "userPrincipalName eq '$userUPN'").Id
         if ($userId) {
 
             # Add user to group
             New-MgGroupMember -GroupId $groupId -DirectoryObjectId $userId
             Write-Output "Added $userUPN to group $groupId"
         } else {
             Write-Output "User $userUPN not found"
         }
     }
 } 