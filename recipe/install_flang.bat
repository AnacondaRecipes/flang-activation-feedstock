@echo on

for /f "tokens=1 delims=." %%i in ("%PKG_VERSION%") do (
  set "MAJOR_VER=%%i"
)

:: Determine architecture string for compiler-rt builtins
if "%target_platform%" == "win-arm64" (
    set "ARCH=aarch64"
) else (
    set "ARCH=x86_64"
)

:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
FOR %%F IN (activate deactivate) DO (
    IF NOT EXIST %PREFIX%\etc\conda\%%F.d MKDIR %PREFIX%\etc\conda\%%F.d
    COPY %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    sed -i 's/@MAJOR_VER@/%MAJOR_VER%/g' %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    sed -i 's/@ARCH@/%ARCH%/g' %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
)
