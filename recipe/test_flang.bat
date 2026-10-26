@echo on
REM usage: test_flang.bat <LLVM major version> <compiler-rt builtins arch>
REM FC, FFLAGS and LDFLAGS are set by activate.bat

%FC% hello_world.f90
if %ERRORLEVEL% NEQ 0 exit /b 1
a.exe
if %ERRORLEVEL% NEQ 0 exit /b 1

REM since LLVM 23 the intrinsic modules come from flang-rt; compile, link and run
REM a program using them with FFLAGS/LDFLAGS, as a build system would use them
%FC% %FFLAGS% test_modules.f90 -o test_modules.exe %LDFLAGS%
if %ERRORLEVEL% NEQ 0 exit /b 1
test_modules.exe
if %ERRORLEVEL% NEQ 0 exit /b 1

REM the compiler-rt builtins library that activate.bat adds to LDFLAGS
if not exist "%CONDA_PREFIX%\Library\lib\clang\%~1\lib\windows\clang_rt.builtins-%~2.lib" exit /b 1
