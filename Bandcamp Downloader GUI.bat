@echo off
:: Set console colors for visibility (light text on dark background)
color 0F
:: Set a custom window title
title Bandcamp Album Downloader (GUI)

:: Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ========================================
    echo Python is not installed or not in PATH
    echo ========================================
    echo.
    echo This script requires Python 3.11 or higher.
    echo.
    echo Please install Python from: https://www.python.org/downloads/
    echo.
    echo ========================================
    echo *** IMPORTANT INSTALLATION STEP ***
    echo ========================================
    echo.
    echo During Python installation, you MUST check the box that says:
    echo   "Add Python to PATH" 
    echo   OR
    echo   "Add python.exe to PATH"
    echo.
    echo This allows the script to find Python automatically.
    echo If you skip this step, you'll need to add Python to PATH manually.
    echo.
    echo ========================================
    echo.
    echo Opening Python download page...
    start https://www.python.org/downloads/
    echo.
    echo After installing Python, please run this script again.
    echo.
    pause
    exit /b 1
)

:: Check Python version (needs 3.11+)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
for /f "tokens=1,2 delims=." %%a in ("%PYTHON_VERSION%") do (
    set MAJOR=%%a
    set MINOR=%%b
)
if %MAJOR% LSS 3 (
    echo.
    echo ========================================
    echo Python version too old!
    echo ========================================
    echo.
    echo Found Python %PYTHON_VERSION%, but Python 3.11+ is required.
    echo Please update Python from: https://www.python.org/downloads/
    echo.
    start https://www.python.org/downloads/
    pause
    exit /b 1
)
if %MAJOR% EQU 3 if %MINOR% LSS 11 (
    echo.
    echo ========================================
    echo Python version too old!
    echo ========================================
    echo.
    echo Found Python %PYTHON_VERSION%, but Python 3.11+ is required.
    echo Please update Python from: https://www.python.org/downloads/
    echo.
    start https://www.python.org/downloads/
    pause
    exit /b 1
)

:: Run the Python GUI script in the same folder as this .bat file
:: Use regular python so we can see startup messages, then hide console after GUI loads
python "%~dp0bandcamp_dl_gui.py"

:: If script exits, close console
exit

