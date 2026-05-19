@echo off
REM Installation & Verification Script (Windows)
REM ECE 435 Remote Sensing - Landsat Classification Web App

setlocal enabledelayedexpansion

cls
echo.
echo ========================================================================
echo 🛰️  LANDSAT CLASSIFICATION WEB APP - SETUP ^& VERIFICATION
echo ========================================================================
echo.

REM Step 1: Check Python
echo 📍 STEP 1: Checking Python Installation...
python --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo ✗ Python not found. Please install Python 3.8+
    echo Visit: https://www.python.org/downloads/
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
color 0A
echo ✓ %PYTHON_VERSION%
color 0F
echo.

REM Step 2: Create virtual environment
echo 📍 STEP 2: Setting up Python Virtual Environment...
cd /d Code

if exist venv (
    echo Virtual environment already exists, skipping creation...
) else (
    python -m venv venv
    if errorlevel 1 (
        color 0C
        echo ✗ Failed to create virtual environment
        pause
        exit /b 1
    )
    color 0A
    echo ✓ Virtual environment created
    color 0F
)

REM Activate virtual environment
call venv\Scripts\activate.bat
color 0A
echo ✓ Virtual environment activated
color 0F
echo.

REM Step 3: Install dependencies
echo 📍 STEP 3: Installing Python Dependencies...
echo This may take a minute...
pip install -q --upgrade pip >nul 2>&1
pip install -q -r requirements.txt
if errorlevel 1 (
    color 0C
    echo ✗ Failed to install dependencies
    pause
    exit /b 1
)
color 0A
echo ✓ All dependencies installed
color 0F
echo.

REM Step 4: Verify project structure
echo 📍 STEP 4: Verifying Project Structure...

setlocal enabledelayedexpansion
set all_ok=1

for %%f in (
    "app.py"
    "config.py"
    "requirements.txt"
    "templates\index.html"
    "static\style.css"
    "static\script.js"
) do (
    if exist "%%f" (
        color 0A
        echo ✓ %%f
        color 0F
    ) else (
        color 0C
        echo ✗ %%f ^(MISSING^)
        color 0F
        set all_ok=0
    )
)

for %%f in (
    "..\Outputs\best_model.pkl"
    "..\Data\Labeled_ROI.csv"
) do (
    if exist "%%f" (
        color 0A
        echo ✓ %%f
        color 0F
    ) else (
        color 0C
        echo ✗ %%f ^(MISSING^)
        color 0F
        set all_ok=0
    )
)

if "!all_ok!"=="0" (
    color 0C
    echo Some files are missing!
    color 0F
    pause
    exit /b 1
)

echo.

REM Step 5: Run test suite
echo 📍 STEP 5: Running Test Suite...
cd ..
python test_suite.py
if errorlevel 1 (
    echo.
    color 0C
    echo ✗ Tests failed. Check output above.
    color 0F
    pause
    exit /b 1
)

echo.
echo ========================================================================
color 0A
echo ✅ SETUP COMPLETE!
color 0F
echo ========================================================================
echo.
echo 🚀 To start the application:
echo.
echo   Option 1: Run this command
echo   cd Code
echo   python app.py
echo.
echo   Option 2: Double-click run.bat
echo.
echo 🌐 Then open your browser to: http://localhost:5000
echo.
echo 📖 For help, see:
echo    - README.md ^(full documentation^)
echo    - QUICK_START.md ^(quick setup^)
echo    - TECHNICAL_DOCS.md ^(technical details^)
echo.
pause
