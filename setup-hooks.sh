#!/bin/bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Claude Code Voice Notification Hook Setup"
echo "=========================================="
echo ""
echo "Add the following configuration to your ~/.claude/settings.json file:"
echo ""
cat << EOF
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd $PROJECT_DIR && pnpm tsx src/hook-handler.ts"
          }
        ]
      }
    ],
    "SubagentStop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd $PROJECT_DIR && pnpm tsx src/hook-handler.ts"
          }
        ]
      }
    ],
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cd $PROJECT_DIR && pnpm tsx src/hook-handler.ts"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash|Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "cd $PROJECT_DIR && pnpm tsx src/hook-handler.ts"
          }
        ]
      }
    ]
  }
}
EOF
echo ""
echo "Note: Make sure to merge this with your existing settings if you have other hooks configured."
echo ""
echo "Don't forget to:"
echo "1. Copy .env.example to .env"
echo "2. Add your ElevenLabs API key to the .env file"