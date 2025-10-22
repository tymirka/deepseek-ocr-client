@echo off
REM DeepSeek OCR Client Launcher for Windows

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed
    echo Please install Python 3.12+ from https://www.python.org/
    pause
    exit /b 1
)

python start.py