# toolbox.ps1
# Menú sencillo para ejecutar las herramientas

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptsDir = Join-Path $scriptRoot "scripts"

function Show-Menu {
    Clear-Host
    Write-Host "=== Windows Automation Tools ===`n"
    Write-Host "1) Limpiar archivos temporales"
    Write-Host "2) Organizar Descargas por tipo"
    Write-Host "3) Backup de configuraciones"
    Write-Host "0) Salir`n"
}

do {
    Show-Menu
    $choice = Read-Host "Elige una opción"

    switch ($choice) {
        "1" { & (Join-Path $scriptsDir "cleanup-temp.ps1"); Pause }
        "2" { & (Join-Path $scriptsDir "organize-downloads.ps1"); Pause }
        "3" { & (Join-Path $scriptsDir "backup-configs.ps1"); Pause }
        "0" { Write-Host "Saliendo..."; break }
        default {
            Write-Host "Opción no válida."
            Start-Sleep -Seconds 1
        }
    }
} while ($true)
