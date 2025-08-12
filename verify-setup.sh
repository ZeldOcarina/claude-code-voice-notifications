#!/bin/bash

# Claude Code Voice Notifications - Setup Verification Script
# This script verifies that everything is configured correctly

set -e

echo "🔍 Claude Code Voice Notifications - Setup Verification"
echo "======================================================="
echo ""

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# Check dependencies
echo "📦 Checking dependencies..."
if ! pnpm list > /dev/null 2>&1; then
    echo "❌ Dependencies not installed. Run: pnpm install"
    exit 1
fi
echo "✅ Dependencies installed"

# Check .env file
echo ""
echo "🔑 Checking environment configuration..."
if [ ! -f .env ]; then
    echo "❌ .env file not found. Run: cp .env.example .env"
    exit 1
fi

if grep -q "your_api_key_here" .env; then
    echo "⚠️  ElevenLabs API key not configured in .env file"
    echo "   You can still use system TTS fallback"
else
    echo "✅ ElevenLabs API key configured"
fi

# Test system fallback
echo ""
echo "🔊 Testing system TTS fallback..."
if pnpm test:fallback > /dev/null 2>&1; then
    echo "✅ System TTS fallback working"
else
    echo "❌ System TTS fallback failed"
    exit 1
fi

# Test ElevenLabs (if API key is configured)
echo ""
echo "🤖 Testing ElevenLabs TTS..."
if ! grep -q "your_api_key_here" .env; then
    if timeout 10s pnpm test > /dev/null 2>&1; then
        echo "✅ ElevenLabs TTS working"
    else
        echo "⚠️  ElevenLabs TTS failed (check API key/credits)"
        echo "   System fallback will be used automatically"
    fi
else
    echo "⏭️  Skipping ElevenLabs test (API key not configured)"
fi

# Check Claude Code settings
echo ""
echo "⚙️  Checking Claude Code configuration..."
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ ! -f "$CLAUDE_SETTINGS" ]; then
    echo "⚠️  Claude Code settings file not found: $CLAUDE_SETTINGS"
    echo "   Run ./setup-hooks.sh to see the required configuration"
else
    if grep -q "voice-notifications" "$CLAUDE_SETTINGS"; then
        echo "✅ Voice notifications configured in Claude Code settings"
    else
        echo "⚠️  Voice notifications not found in Claude Code settings"
        echo "   Run ./setup-hooks.sh to see the required configuration"
    fi
fi

echo ""
echo "📋 Verification Summary:"
echo "========================"

# Dependencies
if pnpm list > /dev/null 2>&1; then
    echo "✅ Dependencies: OK"
else
    echo "❌ Dependencies: Missing"
fi

# Environment
if [ -f .env ] && ! grep -q "your_api_key_here" .env; then
    echo "✅ Environment: Configured"
elif [ -f .env ]; then
    echo "⚠️  Environment: Partial (API key needed)"
else
    echo "❌ Environment: Missing"
fi

# System TTS
if pnpm test:fallback > /dev/null 2>&1; then
    echo "✅ System TTS: Working"
else
    echo "❌ System TTS: Failed"
fi

# ElevenLabs TTS
if [ -f .env ] && ! grep -q "your_api_key_here" .env; then
    if timeout 5s pnpm test > /dev/null 2>&1; then
        echo "✅ ElevenLabs TTS: Working"
    else
        echo "⚠️  ElevenLabs TTS: Issues (fallback available)"
    fi
else
    echo "⏭️  ElevenLabs TTS: Not configured"
fi

# Claude Code settings
if [ -f "$CLAUDE_SETTINGS" ] && grep -q "voice-notifications" "$CLAUDE_SETTINGS"; then
    echo "✅ Claude Code: Configured"
else
    echo "⚠️  Claude Code: Needs configuration"
fi

echo ""
echo "🎯 Next Steps:"
if [ ! -f .env ] || grep -q "your_api_key_here" .env; then
    echo "1. Configure ElevenLabs API key in .env file"
fi
if [ ! -f "$CLAUDE_SETTINGS" ] || ! grep -q "voice-notifications" "$CLAUDE_SETTINGS"; then
    echo "2. Run ./setup-hooks.sh and add configuration to ~/.claude/settings.json"
    echo "3. Restart Claude Code"
fi
echo ""
echo "✨ Once configured, you'll get voice notifications for Claude Code events!"