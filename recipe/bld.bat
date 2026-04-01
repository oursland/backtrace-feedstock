@echo off

set "MSYSTEM=MINGW64"
set "MSYS2_PATH_TYPE=inherit"
set "CHERE_INVOKING=1"

:: Convert paths to MSYS-style paths for configure
FOR /F "delims=" %%i IN ('cygpath.exe -u "%LIBRARY_PREFIX%"') DO set "PREFIX_UNIX=%%i"

bash -lc "CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ ./configure --prefix=${PREFIX_UNIX} --enable-shared --enable-static"
if errorlevel 1 exit 1

bash -lc "make LDFLAGS='-no-undefined'"
if errorlevel 1 exit 1

bash -lc "make install LDFLAGS='-no-undefined'"
if errorlevel 1 exit 1
