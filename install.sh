#!/bin/bash
# Installation & Verification Script
# ECE 435 Remote Sensing - Landsat Classification Web App

set -e  # Exit on error

echo ""
echo "========================================================================"
echo "🛰️  LANDSAT CLASSIFICATION WEB APP - SETUP & VERIFICATION"
echo "========================================================================"
echo ""

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Check Python
echo "📍 STEP 1: Checking Python Installation..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}✗ Python3 not found. Please install Python 3.8+${NC}"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo -e "${GREEN}✓ $PYTHON_VERSION${NC}"
echo ""

# Step 2: Create virtual environment
echo "📍 STEP 2: Setting up Python Virtual Environment..."
cd Code

if [ -d "venv" ]; then
    echo "Virtual environment already exists, skipping creation..."
else
    python3 -m venv venv
    echo -e "${GREEN}✓ Virtual environment created${NC}"
fi

# Activate virtual environment
source venv/bin/activate
echo -e "${GREEN}✓ Virtual environment activated${NC}"
echo ""

# Step 3: Install dependencies
echo "📍 STEP 3: Installing Python Dependencies..."
pip install -q --upgrade pip
pip install -q -r requirements.txt
echo -e "${GREEN}✓ All dependencies installed${NC}"
echo ""

# Step 4: Verify project structure
echo "📍 STEP 4: Verifying Project Structure..."

files_to_check=(
    "app.py"
    "config.py"
    "requirements.txt"
    "templates/index.html"
    "static/style.css"
    "static/script.js"
    "../Outputs/best_model.pkl"
    "../Data/Labeled_ROI.csv"
)

all_files_exist=true
for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file"
    else
        echo -e "${RED}✗${NC} $file (MISSING)"
        all_files_exist=false
    fi
done

if [ "$all_files_exist" = false ]; then
    echo -e "${RED}Some files are missing!${NC}"
    exit 1
fi

echo ""

# Step 5: Run test suite
echo "📍 STEP 5: Running Test Suite..."
cd ..
python3 test_suite.py

echo ""
echo "========================================================================"
echo -e "${GREEN}✅ SETUP COMPLETE!${NC}"
echo "========================================================================"
echo ""
echo "🚀 To start the application:"
echo ""
echo "   cd Code"
echo "   python3 app.py"
echo ""
echo "🌐 Then open your browser to: http://localhost:5000"
echo ""
echo "📖 For help, see:"
echo "   - README.md (full documentation)"
echo "   - QUICK_START.md (quick setup)"
echo "   - TECHNICAL_DOCS.md (technical details)"
echo ""
