# cleanup-temp.ps1
# Limpia carpetas temporales básicas de Windows para el usuario actual.

Write-Host "=== Limpieza de archivos temporales ===`n"

# Carpetas objetivo
$paths = @(
    $env:TEMP,
    "$env:WINDIR\Temp"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "Limpiando: $path"
        try {
            Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue |
                Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "  -> OK"
        }
        catch {
            Write-Warning "  -> Error al limpiar $path : $($_.Exception.Message)"
        }
    }
    else {
        Write-Host "No existe: $path"
    }
}

Write-Host "`nLimpieza completada."
