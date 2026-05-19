#!/bin/bash
# Quick Start Script for Landsat Classification Web App
# ECE 435 Remote Sensing Project - Group 8

echo "============================================================"
echo "🛰️  Landsat Land Cover Classification - Quick Start"
echo "============================================================"
echo ""

# Check if Python is installed
if ! command -v python &> /dev/null; then
    echo "❌ Python is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✓ Python found: $(python --version)"
echo ""

# Navigate to Code directory
cd Code

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python -m venv venv
    echo "✓ Virtual environment created"
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi

echo "✓ Virtual environment activated"
echo ""

# Install requirements
echo "📚 Installing dependencies..."
pip install -q -r requirements.txt
echo "✓ Dependencies installed"
echo ""

# Start Flask app
echo "🚀 Starting Flask application..."
echo ""
echo "============================================================"
echo "🌐 Web server is running!"
echo "📍 Open your browser and go to: http://localhost:5000"
echo "⏹️  Press Ctrl+C to stop the server"
echo "============================================================"
echo ""

python app.py
