# 📁 Windows Automation Tools

Automatiza tareas comunes de Windows con una colección de scripts
simples y eficientes.\
Este repositorio está pensado para mejorar la productividad, mantener el
sistema limpio y hacer copias de seguridad de configuraciones de forma
automática.

Incluye:

-   🧹 Limpieza de archivos temporales\
-   📂 Organización automática de la carpeta *Descargas*\
-   💾 Copia de seguridad de configuraciones (VSCode, juegos,
    programas...)\
-   🧰 Un toolbox opcional con menú interactivo

------------------------------------------------------------------------

## 🛠️ Scripts incluidos

### 1. `cleanup-temp.ps1` -- Limpiar archivos temporales

Elimina archivos basura de:

-   `%TEMP%`
-   `C:\Windows\Temp`

**Uso:**

``` powershell
.\scripts\cleanup-temp.ps1
```

------------------------------------------------------------------------

### 2. `organize-downloads.ps1` -- Organizar Descargas por tipo

Mueve automáticamente los archivos de la carpeta Descargas a subcarpetas
según su extensión:

-   `Images/`
-   `Archives/`
-   `Installers/`
-   `Documents/`
-   `Other/`

**Uso:**

``` powershell
.\scripts\organize-downloads.ps1
```

------------------------------------------------------------------------

### 3. `backup-configs.ps1` -- Backup de configuraciones

Permite hacer copias de seguridad de configuraciones de programas.\
Las rutas a guardar se definen en:

`config/backup-configs.json`

Por defecto incluye:

-   VSCode → `%APPDATA%\Code\User`

Ejemplo de JSON:

``` json
{
  "backupRoot": "%USERPROFILE%\Backups\configs",
  "paths": [
    {
      "name": "VSCode",
      "path": "%APPDATA%\Code\User"
    }
  ]
}
```

**Uso:**

``` powershell
.\scriptsackup-configs.ps1
```

El script crea una carpeta con fecha/hora dentro de `Backups/configs`.

------------------------------------------------------------------------

### 4. `toolbox.ps1` -- Menú interactivo (opcional)

Un menú sencillo para ejecutar todo desde un solo punto:

``` powershell
.   oolbox.ps1
```

------------------------------------------------------------------------

## 📦 Instalación y requisitos

### 1. Clona el repositorio

``` bash
git clone https://github.com/TU_USUARIO/windows-automation-tools.git
```

### 2. Habilita la ejecución de scripts

``` powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

### 3. Ejecuta cualquier script

``` powershell
cd windows-automation-tools
.\scripts
ombredelscript.ps1
```

------------------------------------------------------------------------

## 🧩 Estructura del proyecto

    windows-automation-tools/
    ├─ scripts/
    │  ├─ cleanup-temp.ps1
    │  ├─ organize-downloads.ps1
    │  └─ backup-configs.ps1
    ├─ config/
    │  └─ backup-configs.json
    ├─ toolbox.ps1   (opcional)
    └─ README.md

------------------------------------------------------------------------

## 🤝 Contribuciones

Ideas futuras:

-   Añadir compresión automática del backup.\
-   Sincronizar backups con OneDrive/Google Drive.\
-   Script para actualizar programas (winget).\
-   Script para limpiar cache de navegadores.

Pull requests bienvenidos.

------------------------------------------------------------------------

## 📜 Licencia

MIT License --- libre para usar, modificar y compartir.
