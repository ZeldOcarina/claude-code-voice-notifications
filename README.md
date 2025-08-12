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

1. **Install the package:**
   ```bash
   npm install -g claude-code-voice-notifications
   ```

2. **Configure ElevenLabs API key (optional but recommended):**
   
   Get your free API key from [ElevenLabs](https://elevenlabs.io/app/settings/api-keys), then add it to your shell:
   
   **For Zsh (.zshrc):**
   ```bash
   echo 'export ELEVENLABS_API_KEY="your_api_key_here"' >> ~/.zshrc
   source ~/.zshrc
   ```
   
   **For Bash (.bashrc):**
   ```bash
   echo 'export ELEVENLABS_API_KEY="your_api_key_here"' >> ~/.bashrc
   source ~/.bashrc
   ```
   
   **For Fish (.config/fish/config.fish):**
   ```bash
   echo 'set -gx ELEVENLABS_API_KEY "your_api_key_here"' >> ~/.config/fish/config.fish
   source ~/.config/fish/config.fish
   ```

3. **Test the installation:**
   ```bash
   # Test with system TTS (works without API key)
   echo '{"hook_event_name": "Stop"}' | claude-voice-notifications
   
   # Test with ElevenLabs (needs API key configured above)
   echo '{"hook_event_name": "SubagentStop", "tool_input": {"description": "Test Task"}}' | claude-voice-notifications
   ```

4. **Configure Claude Code hooks:**
   Add the configuration below to your `~/.claude/settings.json`

5. **Restart Claude Code** to activate notifications!

## ⚙️ Configuration

### Hook Events Supported

| Event | Trigger | Example Notification |
|-------|---------|---------------------|
| **Stop** | Claude finishes responding | *"Claude has finished responding"* |
| **SubagentStop** | Subagent completes task | *"Subagent finished: Code review"* |
| **Notification** | Permission/input needed | *"Claude needs your permission"* |
| **PostToolUse** | Tool operation completes | *"Build completed"* |

### Claude Code Settings

Add this configuration to your `~/.claude/settings.json`:

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

### Voice Customization

You can customize the voice by setting environment variables:

```bash
# Use a different voice (get voice IDs from ElevenLabs)
export ELEVENLABS_VOICE_ID="pNInz6obpgDQGcFmaJgB"  # Adam voice

# Add to your shell config (.zshrc, .bashrc, etc.)
echo 'export ELEVENLABS_VOICE_ID="pNInz6obpgDQGcFmaJgB"' >> ~/.zshrc
```

Available voice IDs from ElevenLabs:
- `JBFqnCBsd6RMkjVDRZzb` - George (default)
- `pNInz6obpgDQGcFmaJgB` - Adam
- `21m00Tcm4TlvDq8ikWAM` - Rachel
- `AZnzlk1XvdvUeBnXmlld` - Domi

## 📋 Testing Commands

```bash
# Test different events
echo '{"hook_event_name": "Stop"}' | claude-voice-notifications
echo '{"hook_event_name": "SubagentStop", "tool_input": {"description": "Test Task"}}' | claude-voice-notifications  
echo '{"hook_event_name": "Notification", "message": "Claude needs permission"}' | claude-voice-notifications
echo '{"hook_event_name": "PostToolUse", "tool_name": "Bash", "tool_input": {"command": "npm run build"}}' | claude-voice-notifications

# Test with specific voice
ELEVENLABS_VOICE_ID="pNInz6obpgDQGcFmaJgB" echo '{"hook_event_name": "Stop"}' | claude-voice-notifications
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

If you want to contribute or modify the code:

```bash
git clone https://github.com/ZeldOcarina/claude-code-voice-notifications.git
cd claude-code-voice-notifications
npm install  # or pnpm install
npm run test  # Verify setup (requires API key)
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
- [Report Issues](https://github.com/ZeldOcarina/claude-code-voice-notifications/issues)

---

**Made with ❤️ for the Claude Code community**

*Transform your coding workflow with intelligent voice notifications!*