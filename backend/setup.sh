#!/bin/bash

# VidRush Backend Setup Script

echo "🚀 Setting up VidRush Backend..."

# Create virtual environment
echo "📦 Creating virtual environment..."
python -m venv venv

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo "📚 Installing dependencies..."
pip install -r requirements.txt

# Create downloads directory
echo "📁 Creating downloads directory..."
mkdir -p downloads

# Test the application
echo "🧪 Testing the application..."
python -c "import main; print('✅ Backend setup complete!')"

echo ""
echo "🎉 Setup complete! You can now:"
echo "1. Run locally: uvicorn main:app --reload --host 0.0.0.0 --port 8000"
echo "2. Build Docker: docker build -t vidrush-backend ."
echo "3. Deploy to Render/Railway using the deployment guide"
echo ""
echo "📖 API Documentation will be available at:"
echo "- http://localhost:8000/docs (Swagger UI)"
echo "- http://localhost:8000/redoc (ReDoc)" 