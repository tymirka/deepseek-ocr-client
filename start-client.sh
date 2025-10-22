#!/bin/bash

# DeepSeek OCR Client Startup Script with Integrated Setup

echo "======================================"
echo "DeepSeek OCR Client"
echo "======================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "✗ Node.js is not installed"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "✗ Python 3 is not installed"
    echo "Please install Python 3.12+ from https://www.python.org/"
    exit 1
fi

# Install/Update Node.js dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "Installing Node.js dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "✗ Failed to install Node.js dependencies"
        exit 1
    fi
    echo "✓ Node.js dependencies installed"
fi

# Check if conda is available
if command -v conda &> /dev/null; then
    USE_CONDA=true
    # Check if conda environment exists
    if conda env list | grep -q deepseek-ocr; then
        echo "Activating Conda environment..."
        source $(conda info --base)/etc/profile.d/conda.sh
        conda activate deepseek-ocr
    else
        echo "Creating Conda environment..."
        conda create -n deepseek-ocr python=3.12.9 -y
        source $(conda info --base)/etc/profile.d/conda.sh
        conda activate deepseek-ocr

        # Install PyTorch
        echo ""
        if command -v nvidia-smi &> /dev/null; then
            echo "✓ NVIDIA GPU detected"
            nvidia-smi --query-gpu=name --format=csv,noheader
            echo "Installing PyTorch with CUDA support..."
            pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu118
        else
            echo "! No NVIDIA GPU detected"
            echo "Installing PyTorch CPU version..."
            pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cpu
        fi

        if [ $? -ne 0 ]; then
            echo "✗ Failed to install PyTorch"
            exit 1
        fi

        # Install other Python dependencies
        echo "Installing Python dependencies..."
        pip install -r requirements.txt
        if [ $? -ne 0 ]; then
            echo "✗ Failed to install Python dependencies"
            exit 1
        fi
        echo "✓ Python dependencies installed"
    fi
else
    USE_CONDA=false
    # Check if venv exists
    if [ -d "venv" ]; then
        echo "Activating virtual environment..."
        source venv/bin/activate
    else
        echo "Creating Python virtual environment..."
        python3 -m venv venv
        source venv/bin/activate

        # Install PyTorch
        echo ""
        if command -v nvidia-smi &> /dev/null; then
            echo "✓ NVIDIA GPU detected"
            nvidia-smi --query-gpu=name --format=csv,noheader
            echo "Installing PyTorch with CUDA support..."
            pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu118
        else
            echo "! No NVIDIA GPU detected"
            echo "Installing PyTorch CPU version..."
            pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cpu
        fi

        if [ $? -ne 0 ]; then
            echo "✗ Failed to install PyTorch"
            exit 1
        fi

        # Install other Python dependencies
        echo "Installing Python dependencies..."
        pip install -r requirements.txt
        if [ $? -ne 0 ]; then
            echo "✗ Failed to install Python dependencies"
            exit 1
        fi
        echo "✓ Python dependencies installed"
    fi
fi

echo ""
echo "Starting DeepSeek OCR Client..."
npm start
