# Uninstall Microsoft.Graph modules except Microsoft.Graph.Authentication

# Remove all Microsoft.Graph modules except Authentication
$Modules = Get-Module Microsoft.Graph* -ListAvailable |
    Where-Object { $_.Name -ne "Microsoft.Graph.Authentication" } |
    Select-Object -ExpandProperty Name -Unique

foreach ($ModuleName in $Modules) {
    $Versions = Get-Module $ModuleName -ListAvailable | Select-Object -ExpandProperty Version -Unique
    foreach ($ModuleVersion in $Versions) {
        Write-Host "Uninstall-Module $ModuleName -RequiredVersion $ModuleVersion"
        Uninstall-Module $ModuleName -RequiredVersion $ModuleVersion -ErrorAction SilentlyContinue
    }
}

# Uninstall modules that couldn't be removed above (installed via PowerShellGet)
$InstalledModules = Get-InstalledModule Microsoft.Graph* |
    Where-Object { $_.Name -ne "Microsoft.Graph.Authentication" } |
    Select-Object -ExpandProperty Name -Unique

foreach ($InstalledModuleName in $InstalledModules) {
    $InstalledVersions = Get-InstalledModule $InstalledModuleName -AllVersions
    foreach ($InstalledVersion in $InstalledVersions) {
        $InstalledModuleVersion = $InstalledVersion.Version
        Write-Host "Uninstall-Module $InstalledModuleName -RequiredVersion $InstalledModuleVersion"
        Uninstall-Module $InstalledModuleName -RequiredVersion $InstalledModuleVersion -ErrorAction SilentlyContinue
    }
}

# Uninstall Microsoft.Graph.Authentication
$ModuleName = "Microsoft.Graph.Authentication"
$Versions = Get-InstalledModule $ModuleName -AllVersions
foreach ($Version in $Versions) {
    $ModuleVersion = $Version.Version
    Write-Host "Uninstall-Module $ModuleName -RequiredVersion $ModuleVersion"
    Uninstall-Module $ModuleName -RequiredVersion $ModuleVersion -ErrorAction SilentlyContinue
}