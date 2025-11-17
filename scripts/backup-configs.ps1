# backup-configs.ps1
# Hace copia de seguridad de configuraciones definidas en config/backup-configs.json

Write-Host "=== Backup de configuraciones ===`n"

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot   = Split-Path -Parent $scriptRoot
$configFile = Join-Path $repoRoot "config\backup-configs.json"

if (-not (Test-Path $configFile)) {
    Write-Error "No se encuentra el archivo de configuración: $configFile"
    exit 1
}

# Leer JSON
$jsonRaw = Get-Content -Path $configFile -Raw
$config = $jsonRaw | ConvertFrom-Json

# Expandir variables de entorno tipo %USERPROFILE%
function Expand-EnvVars([string]$text) {
    return [Environment]::ExpandEnvironmentVariables($text)
}

$backupRoot = Expand-EnvVars $config.backupRoot
$timestamp  = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$backupDir  = Join-Path $backupRoot $timestamp

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

foreach ($item in $config.paths) {
    $name = $item.name
    $path = Expand-EnvVars $item.path

    Write-Host "Haciendo backup de '$name' desde: $path"

    if (-not (Test-Path $path)) {
        Write-Warning "  -> Ruta no encontrada, se omite."
        continue
    }

    $target = Join-Path $backupDir $name

    try {
        Copy-Item -Path $path -Destination $target -Recurse -Force
        Write-Host "  -> Backup OK en: $target"
    }
    catch {
        Write-Warning "  -> Error al copiar '$name': $($_.Exception.Message)"
    }
}

Write-Host "`nBackups completados en: $backupDir"
