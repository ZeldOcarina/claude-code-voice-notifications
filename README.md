# 🔊 Claude Code Voice Notifications

> **Get instant audio notifications when Claude Code completes tasks, needs permissions, or finishes operations!**

Transform your Claude Code workflow with intelligent voice notifications powered by ElevenLabs TTS. Never miss when Claude finishes a task, needs your permission, or completes important operations.

[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![ElevenLabs](https://img.shields.io/badge/ElevenLabs-FF6B35?style=flat-square&logo=elevenlabs&logoColor=white)](https://elevenlabs.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

## ✨ Features

- **🎙️ Natural TTS** - Uses ElevenLabs AI voices for lifelike notifications
- **🔄 Smart Fallback** - Automatically falls back to system TTS if API fails
- **🎯 Contextual Messages** - Different notifications for different events
- **⚡ Ultra-Low Latency** - Flash v2.5 model provides ~75ms response time
- **🛡️ Never Fails** - Built-in error handling ensures you always get notified
- **🌍 Cross-Platform** - Works on macOS, Linux, and Windows
- **⚙️ Configurable** - Easy to customize voices, models, and messages

## 📺 Demo

When Claude Code:
- ✅ Finishes responding → *"Claude has finished responding"*
- 🤖 Completes subagent tasks → *"Subagent finished: [task name]"*
- 🔔 Needs permission → *"Claude needs your permission"*
- 📝 Completes file edits → *"File edited: config.ts"*
- 🔨 Finishes builds → *"Build completed"*
- 📦 Installs packages → *"Package installation completed"*

## 🚀 Quick Start

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- [Node.js](https://nodejs.org/) 18+ and [pnpm](https://pnpm.io/)
- [ElevenLabs API key](https://elevenlabs.io/app/settings/api-keys) (free tier works!)
- [ffmpeg](https://ffmpeg.org/) for audio playback

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/claude-code-voice-notifications.git
   cd claude-code-voice-notifications
   ```

2. **Install dependencies:**
   ```bash
   pnpm install
   ```

3. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env and add your ElevenLabs API key
   ```

4. **Test the system:**
   ```bash
   pnpm test              # Test basic notification
   pnpm test:notification # Test permission prompt
   pnpm test:posttool     # Test tool completion
   pnpm test:fallback     # Test system TTS fallback
   ```

5. **Configure Claude Code hooks:**
   ```bash
   ./setup-hooks.sh       # Shows configuration to add to ~/.claude/settings.json
   ```

6. **Restart Claude Code** to activate the hooks!

## ⚙️ Configuration

### Hook Events Supported

| Event | Trigger | Example Notification |
|-------|---------|---------------------|
| **Stop** | Claude finishes responding | *"Claude has finished responding"* |
| **SubagentStop** | Subagent completes task | *"Subagent finished: Code review"* |
| **Notification** | Permission/input needed | *"Claude needs your permission"* |
| **PostToolUse** | Tool operation completes | *"Build completed"* |

### Claude Code Settings

Add this to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && pnpm tsx src/hook-handler.ts"
      }]
    }],
    "SubagentStop": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && pnpm tsx src/hook-handler.ts"
      }]
    }],
    "Notification": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && pnpm tsx src/hook-handler.ts"
      }]
    }],
    "PostToolUse": [{
      "matcher": "Bash|Edit|MultiEdit|Write",
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && pnpm tsx src/hook-handler.ts"
      }]
    }]
  }
}
```

### Voice Customization

Edit `src/config.ts` to customize:

```typescript
export const config = {
  elevenLabs: {
    voiceId: 'JBFqnCBsd6RMkjVDRZzb', // Change voice
    modelId: 'eleven_flash_v2_5',     // Ultra-low latency
    outputFormat: 'mp3_44100_128',    // Audio quality
  },
  notifications: {
    stopMessage: 'Claude has finished responding.',
    // ... customize all messages
  },
};
```

## 📋 Available Scripts

```bash
pnpm start              # Run the hook handler
pnpm test               # Test Stop event
pnpm test:subagent      # Test SubagentStop event  
pnpm test:notification  # Test Notification event
pnpm test:posttool      # Test PostToolUse event
pnpm test:fallback      # Test system TTS fallback
pnpm build              # Build TypeScript
```

## 🔧 Advanced Configuration

### Selective Tool Notifications

Customize the PostToolUse matcher to only notify for specific tools:

```json
{
  "PostToolUse": [{
    "matcher": "Bash",  // Only bash commands
    "hooks": [...]
  }]
}
```

### Multiple Voice Configurations

Run different voices for different events:

```bash
# Create separate .env files
cp .env .env.stop
cp .env .env.error

# Use different voice IDs in each
# Configure separate commands in hooks
```

## 💡 Use Cases

- **Long-running builds** - Get notified when builds complete
- **File operations** - Know when important files are modified  
- **Multi-tasking** - Work on other things while Claude works
- **Accessibility** - Audio feedback for visual impairments
- **Remote work** - Get notified even when not looking at screen

## 🛠️ Troubleshooting

### No audio playing
- Check your ElevenLabs API key in `.env`
- Ensure ffmpeg is installed: `brew install ffmpeg` (macOS)
- Test fallback: `pnpm test:fallback`

### Hook not triggering
- Verify hooks configuration in `~/.claude/settings.json`
- Restart Claude Code after configuration changes
- Check hook syntax with `./setup-hooks.sh`

### Permission errors
- Ensure script has execute permissions: `chmod +x setup-hooks.sh`
- Check file paths in hook commands

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
git clone https://github.com/yourusername/claude-code-voice-notifications.git
cd claude-code-voice-notifications
pnpm install
pnpm test:fallback  # Verify setup
```

### Adding New Features

- New TTS providers (Google, AWS, Azure)
- Additional hook events (PreCompact, UserPromptSubmit)
- Custom voice personalities per event type
- Integration with Slack/Discord notifications

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- [Anthropic](https://anthropic.com) for Claude Code and hooks system
- [ElevenLabs](https://elevenlabs.io) for amazing TTS technology
- Claude Code community for inspiration and feedback

## 🔗 Links

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Claude Code Hooks Guide](https://docs.anthropic.com/claude-code/hooks)
- [ElevenLabs API](https://elevenlabs.io/docs)
- [Report Issues](https://github.com/yourusername/claude-code-voice-notifications/issues)

---

**Made with ❤️ for the Claude Code community**

*Transform your coding workflow with intelligent voice notifications!*