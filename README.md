# 🔊 Claude Code Voice Notifications

> **Get instant audio notifications when Claude Code completes tasks, needs permissions, or finishes operations!**

Transform your Claude Code workflow with intelligent voice notifications powered by ElevenLabs TTS. Never miss when Claude finishes a task, needs your permission, or completes important operations.

## 🤖 **100% AI Generated**

> ⚡ **This entire project was built from scratch using Claude Code with 100% AI-generated code!**  
> From initial concept to production-ready open source package - every line of TypeScript, documentation, configuration, and tooling was created by AI. This showcases the power of Claude Code for end-to-end software development.

[![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![ElevenLabs](https://img.shields.io/badge/ElevenLabs-FF6B35?style=flat-square&logo=elevenlabs&logoColor=white)](https://elevenlabs.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![AI Generated](https://img.shields.io/badge/🤖%20AI%20Generated-100%25-brightgreen?style=flat-square)](https://claude.ai/code)
[![Built with Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-blueviolet?style=flat-square)](https://claude.ai/code)

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
- [Node.js](https://nodejs.org/) 18+
- [ElevenLabs API key](https://elevenlabs.io/app/settings/api-keys) (free tier works!)
- [ffmpeg](https://ffmpeg.org/) for audio playback (auto-installed on most systems)

### Installation

#### 🎯 Option 1: npm (Recommended)

1. **Install globally:**
   ```bash
   npm install -g claude-code-voice-notifications
   ```

2. **Quick setup:**
   ```bash
   # Create .env file with your ElevenLabs API key
   echo "ELEVENLABS_API_KEY=your_api_key_here" > ~/.claude-voice-notifications.env
   
   # Test the system (uses system TTS fallback, no API key needed)
   echo '{"hook_event_name": "Stop"}' | claude-voice-notifications
   ```

3. **Configure Claude Code hooks:**
   Use the configuration shown below in your `~/.claude/settings.json`

4. **Restart Claude Code** to activate notifications!

#### 🛠️ Option 2: From Source (Development)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ZeldOcarina/claude-code-voice-notifications.git
   cd claude-code-voice-notifications
   ```

2. **Install dependencies:**
   ```bash
   npm install  # or pnpm install
   ```

3. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env and add your ElevenLabs API key
   ```

4. **Test the system:**
   ```bash
   npm run test:fallback     # Test system TTS fallback (no API key needed)
   npm run test              # Test with ElevenLabs (needs API key)
   ```

5. **Configure Claude Code hooks:**
   ```bash
   ./setup-hooks.sh       # Shows configuration
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

#### If installed via npm:
```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "claude-voice-notifications"
      }]
    }],
    "SubagentStop": [{
      "hooks": [{
        "type": "command",
        "command": "claude-voice-notifications"
      }]
    }],
    "Notification": [{
      "hooks": [{
        "type": "command",
        "command": "claude-voice-notifications"
      }]
    }],
    "PostToolUse": [{
      "matcher": "Bash|Edit|MultiEdit|Write",
      "hooks": [{
        "type": "command",
        "command": "claude-voice-notifications"
      }]
    }]
  }
}
```

#### If installed from source:
```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && npm run start"
      }]
    }],
    "SubagentStop": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && npm run start"
      }]
    }],
    "Notification": [{
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && npm run start"
      }]
    }],
    "PostToolUse": [{
      "matcher": "Bash|Edit|MultiEdit|Write",
      "hooks": [{
        "type": "command",
        "command": "cd /path/to/claude-code-voice-notifications && npm run start"
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

**Special Note**: This project demonstrates Claude Code's capability for complete software development - from architecture and coding to documentation and DevOps setup, all generated through AI assistance.

## 🔗 Links

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Claude Code Hooks Guide](https://docs.anthropic.com/claude-code/hooks)
- [ElevenLabs API](https://elevenlabs.io/docs)
- [Report Issues](https://github.com/yourusername/claude-code-voice-notifications/issues)

---

**Made with ❤️ for the Claude Code community**

*Transform your coding workflow with intelligent voice notifications!*