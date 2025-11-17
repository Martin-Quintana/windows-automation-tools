# organize-downloads.ps1
# Organiza la carpeta Descargas por tipo de archivo.

Write-Host "=== Organizar carpeta Descargas por tipo ===`n"

$downloads = Join-Path $env:USERPROFILE "Downloads"

if (-not (Test-Path $downloads)) {
    Write-Error "La carpeta de Descargas no existe: $downloads"
    exit 1
}

# Map de extensión → carpeta
$rules = @{
    "Images"     = @(".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp");
    "Archives"   = @(".zip", ".rar", ".7z", ".tar", ".gz");
    "Installers" = @(".exe", ".msi", ".msix", ".bat");
    "Documents"  = @(".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".txt");
}

# Crear subcarpetas si no existen
$rules.Keys + "Other" | ForEach-Object {
    $folder = Join-Path $downloads $_
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
    }
}

# Obtener archivos (solo nivel superior, no subcarpetas)
$files = Get-ChildItem -Path $downloads -File

foreach ($file in $files) {
    $ext = $file.Extension.ToLower()
    $targetFolder = $null

    foreach ($key in $rules.Keys) {
        if ($rules[$key] -contains $ext) {
            $targetFolder = Join-Path $downloads $key
            break
        }
    }

    if (-not $targetFolder) {
        $targetFolder = Join-Path $downloads "Other"
    }

    $targetPath = Join-Path $targetFolder $file.Name

    Write-Host "Moviendo '$($file.Name)' → '$targetFolder'"
    try {
        Move-Item -Path $file.FullName -Destination $targetPath -Force
    }
    catch {
        Write-Warning "  -> No se pudo mover $($file.Name): $($_.Exception.Message)"
    }
}

Write-Host "`nOrganización completada."
