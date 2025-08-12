#!/bin/bash

# Claude Code Voice Notifications - Installation Script
# This script automates the installation and setup process

set -e  # Exit on any error

echo "🔊 Claude Code Voice Notifications - Installation"
echo "================================================"
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version is too old. Please install Node.js 18+ from https://nodejs.org/"
    exit 1
fi
echo "✅ Node.js $(node --version) found"

# Check pnpm
if ! command -v pnpm &> /dev/null; then
    echo "⚠️  pnpm not found. Installing pnpm..."
    npm install -g pnpm
    echo "✅ pnpm installed"
else
    echo "✅ pnpm $(pnpm --version) found"
fi

# Check ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo "⚠️  ffmpeg not found"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "   Installing ffmpeg via Homebrew..."
        if command -v brew &> /dev/null; then
            brew install ffmpeg
            echo "✅ ffmpeg installed"
        else
            echo "❌ Homebrew not found. Please install ffmpeg manually from https://ffmpeg.org/"
            echo "   Or install Homebrew first: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        fi
    else
        echo "   Please install ffmpeg from https://ffmpeg.org/"
        echo "   Ubuntu/Debian: sudo apt install ffmpeg"
        echo "   CentOS/RHEL: sudo yum install ffmpeg"
    fi
else
    echo "✅ ffmpeg found"
fi

echo ""
echo "📦 Installing dependencies..."
pnpm install

echo ""
echo "🔧 Setting up configuration..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ Created .env file from template"
    echo ""
    echo "⚠️  IMPORTANT: Please add your ElevenLabs API key to .env file"
    echo "   1. Get your API key from: https://elevenlabs.io/app/settings/api-keys"
    echo "   2. Edit .env file and replace 'your_api_key_here' with your actual key"
    echo ""
else
    echo "✅ .env file already exists"
fi

echo ""
echo "🧪 Testing installation..."
echo "Testing system TTS fallback..."
pnpm test:fallback

echo ""
echo "✅ Installation completed!"
echo ""
echo "📋 Next steps:"
echo "1. Edit .env file and add your ElevenLabs API key (if you haven't already)"
echo "2. Test with ElevenLabs: pnpm test"
echo "3. Configure Claude Code hooks: ./setup-hooks.sh"
echo "4. Copy the hook configuration to ~/.claude/settings.json"
echo "5. Restart Claude Code"
echo ""
echo "🎉 Enjoy your voice notifications!"