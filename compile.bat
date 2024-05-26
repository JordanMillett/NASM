@echo off

cls

REM Check if arguments were provided
if "%~1"=="" (
    echo No arguments provided.
    echo Usage: %~nx0 [run build debug]
    exit /b 1
)

REM Perform different actions based on the provided argument
if /i "%~1"=="run" (
    
    call:build
    echo Running...
    if exist bin/program.exe (
        call "bin/program.exe" || echo Application Crashed. Please Debug. && exit /b
    ) else (
        echo File does not exist. && exit /b 2
    )
    
    echo Application ended successfully. && exit /b 0
    
) else if /i "%~1"=="debug" (
    
    call:build
    echo Debugging...
    if exist bin/program.exe (
        gdb bin/program.exe || echo Debugger Quit. && exit /b
    ) else (
        echo File does not exist. && exit /b 2
    )
    
    echo Application ended. && exit /b 0
    
) else if /i "%~1"=="build" (
    
    call:build
    
    echo Application built successfully. && exit /b 0
) else (
    echo Wrong arguments provided.
    echo Usage: %~nx0 [run build debug]
    exit /b 1
)

:build 
echo Building...
nasm -f win32 program.asm -o obj/program.obj || echo OBJ building failed. && exit /b
link /subsystem:console /entry:start obj/program.obj kernel32.lib user32.lib /out:bin/program.exe || echo Linking failed. && exit /b
goto:eof