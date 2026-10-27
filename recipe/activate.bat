set "CONDA_BACKUP_FC=%FC%"
set "CONDA_BACKUP_FFLAGS=%FFLAGS%"
set "CONDA_BACKUP_FC_LD=%FC_LD%"
set "CONDA_BACKUP_LDFLAGS=%LDFLAGS%"
set "CONDA_BACKUP_AR=%AR%"

set "FC=flang.exe"
set "FC_LD=lld-link.exe"
set "AR=llvm-ar.exe"

:: following https://github.com/conda-forge/clang-win-activation-feedstock/blob/main/recipe/activate-clang_win-64.bat
set "FFLAGS=-D_CRT_SECURE_NO_WARNINGS -fms-runtime-lib=dll -fuse-ld=lld"
set "LDFLAGS=%LDFLAGS% -Wl,-defaultlib:%CONDA_PREFIX:\=/%/Library/lib/clang/@MAJOR_VER@/lib/windows/clang_rt.builtins-@ARCH@.lib"

:: need to distinguish how we populate `-I` based on whether we're using conda build or not:
:: under conda-build use %PREFIX% (the host env.), otherwise %CONDA_PREFIX% (the user env.;
:: under conda-build it points to the build env.). Normalized to `/` so the flags survive
:: response files, which treat backslashes as escapes.
if not "%CONDA_BUILD%" == "" (
    set "FFLAGS=%FFLAGS% -I%PREFIX:\=/%/Library/include"
) else (
    set "FFLAGS=%FFLAGS% -I%CONDA_PREFIX:\=/%/Library/include"
)
