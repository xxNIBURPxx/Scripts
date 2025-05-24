# Uninstall all AzureAD modules (AzureAD and AzureADPreview)

$ModuleNames = @('AzureAD', 'AzureADPreview')

foreach ($ModuleName in $ModuleNames) {
    # Uninstall all installed versions
    $InstalledModules = Get-InstalledModule -Name $ModuleName -ErrorAction SilentlyContinue
    foreach ($Module in $InstalledModules) {
        Write-Host "Uninstall-Module $($Module.Name) -RequiredVersion $($Module.Version)"
        Uninstall-Module -Name $Module.Name -RequiredVersion $Module.Version -ErrorAction SilentlyContinue
    }

    # Remove from available modules (if any remain)
    $AvailableModules = Get-Module -Name $ModuleName -ListAvailable
    foreach ($Module in $AvailableModules) {
        Write-Host "Removing files for $($Module.Name) version $($Module.Version) from $($Module.ModuleBase)"
        try {
            Remove-Item -Path $Module.ModuleBase -Recurse -Force -ErrorAction Stop
        } catch {
            Write-Warning "Failed to remove $($Module.ModuleBase): $_"
        }
    }
}