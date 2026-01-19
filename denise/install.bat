@echo off
setlocal enabledelayedexpansion

if not exist "urls.txt" (
    echo urls.txt not found.
    exit /b 1
)

for /f "usebackq delims=" %%U in ("urls.txt") do (
    if not "%%U"=="" (
        echo Installing %%U

        echo %%U | findstr /i "modrinth.com" >nul
        if not errorlevel 1 (
            packwiz modrinth install -y "%%U"
        ) else (
            echo %%U | findstr /i "curseforge.com" >nul
            if not errorlevel 1 (
                packwiz curseforge install -y "%%U"
            ) else (
                echo Unknown URL type: %%U
                exit /b 1
            )
        )

        if errorlevel 1 (
            echo Failed to install %%U
            exit /b 1
        )
    )
)

echo All installs completed.
endlocal
