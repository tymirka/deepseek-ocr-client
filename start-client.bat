@echo off
REM DeepSeek OCR Client Startup Script for Windows with Integrated Setup

echo ======================================
echo DeepSeek OCR Client
echo ======================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo X Node.js is not installed
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo X Python is not installed
    echo Please install Python 3.12+ from https://www.python.org/
    pause
    exit /b 1
)

REM Install Node.js dependencies if needed
if not exist "node_modules\" (
    echo Installing Node.js dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo X Failed to install Node.js dependencies
        pause
        exit /b 1
    )
    echo + Node.js dependencies installed
)

REM Check if virtual environment exists
if not exist "venv\" (
    echo Creating Python virtual environment...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo X Failed to create virtual environment
        pause
        exit /b 1
    )

    REM Activate virtual environment
    call venv\Scripts\activate.bat

    REM Check for NVIDIA GPU
    echo.
    where nvidia-smi >nul 2>nul
    if %errorlevel% equ 0 (
        echo + NVIDIA GPU detected
        nvidia-smi --query-gpu=name --format=csv,noheader
        echo Installing PyTorch with CUDA support...
        pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu118
    ) else (
        echo ! No NVIDIA GPU detected
        echo Installing PyTorch CPU version...
        pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cpu
    )

    if %errorlevel% neq 0 (
        echo X Failed to install PyTorch
        pause
        exit /b 1
    )
    echo + PyTorch installed

    REM Install other Python dependencies
    echo.
    echo Installing Python dependencies...
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo X Failed to install Python dependencies
        pause
        exit /b 1
    )
    echo + Python dependencies installed
) else (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
)

echo.
echo Starting DeepSeek OCR Client...
npm start
