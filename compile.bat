@ECHO off

ECHO Is this a release build or a debug build?
ECHO.
ECHO 1. Release
ECHO 2. Debug
ECHO.
CHOICE /C 12 /M "Enter your choice: "

IF ERRORLEVEL 1 set compile="release"
IF ERRORLEVEL 2 set compile="debug"

ECHO.
CHOICE /C YN /M "Do you want to immediately start the game after building? "

IF ERRORLEVEL 1 set launch="y"
IF ERRORLEVEL 2 set launch="n"

IF %compile% == "release" set dir="export/windows/release/bin/"
IF %compile% == "debug" set dir="export/windows/debug/bin/"

ECHO Removing assets folder...
RMDIR /S /Q %dir%assets
ECHO Copying assets...
XCOPY assets %dir%assets /E /I /Y

ECHO Building game...
haxe compile-%compile%.hxml %*
IF %compile% == "release" (
    ECHO Compiling to exe...
    REM ^ stops new lines from being registered
    REM so we have one command on multiple lines,
    REM neat!
    gcc export/windows/release/c/*.c ^
    -O3 -std=c11 ^
    -o export/windows/release/bin/Funkin.exe ^
    -I %HASHLINK_INCLUDE% ^
    -I export/windows/release/c ^
    -L %HASHLINK% %HASHLINK%/libhl.dll ^
    %HASHLINK%/sdl.hdll ^
    %HASHLINK%/ui.hdll ^
    %HASHLINK%/fmt.hdll ^
    %HASHLINK%/openal.hdll ^
    %HASHLINK%/ui.hdll ^
    %HASHLINK%/uv.hdll ^
    %HASHLINK%/heaps.hdll ^
    -lopengl32 -lOpenAL32 ^
    -lmingw32 -lSDL2 ^
    -ldbghelp -lws2_32 ^
    -municode
    REM I have no clue what IS needed here and
    REM what ISN'T, but it works for compilation.
    REM TODO: Clean this up.
)

ECHO Finished!

IF %launch% == "y" (
    IF %compile% == "debug" (
        hl export/windows/debug/bin/Main.hl
    )
    IF %compile% == "release" (
        export\windows\release\bin\Funkin.exe
    )
)

@ECHO on
