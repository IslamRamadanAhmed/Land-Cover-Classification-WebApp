@echo off
REM Quick Start Script for Landsat Classification Web App (Windows)
REM ECE 435 Remote Sensing Project - Group 8

echo.
echo ============================================================
echo 🛰️  Landsat Land Cover Classification - Quick Start
echo ============================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed. Please install Python 3.8 or higher.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
echo ✓ Python found: %PYTHON_VERSION%
echo.

REM Navigate to Code directory
cd /d "%~dp0Code"

REM Check if virtual environment exists
if not exist "venv" (
    echo 📦 Creating virtual environment...
    python -m venv venv
    echo ✓ Virtual environment created
)

REM Activate virtual environment
echo 🔧 Activating virtual environment...
call venv\Scripts\activate.bat
echo ✓ Virtual environment activated
echo.

REM Install requirements
echo 📚 Installing dependencies...
pip install -q -r requirements.txt
if errorlevel 1 (
    echo ❌ Failed to install dependencies
    pause
    exit /b 1
)
echo ✓ Dependencies installed
echo.

REM Start Flask app
echo 🚀 Starting Flask application...
echo.
echo ============================================================
echo 🌐 Web server is running!
echo 📍 Open your browser and go to: http://localhost:5000
echo ⏹️  Press Ctrl+C to stop the server
echo ============================================================
echo.

python app.py
pause
