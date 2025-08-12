# 📋 Configuration Examples

This directory contains example configurations for different use cases and scenarios.

## Available Examples

### 🔧 Basic Configurations
- [`minimal.json`](minimal.json) - Minimal setup with just essential notifications
- [`complete.json`](complete.json) - Full configuration with all hook events
- [`selective.json`](selective.json) - Selective notifications for specific tools only

### 🎯 Specialized Use Cases
- [`build-focused.json`](build-focused.json) - Focus on build/test/deployment notifications
- [`file-operations.json`](file-operations.json) - File editing and creation notifications
- [`development.json`](development.json) - Development-focused with git and package management
- [`accessibility.json`](accessibility.json) - Enhanced accessibility with verbose notifications

### 🔊 Voice Configurations
- [`multiple-voices.json`](multiple-voices.json) - Different voices for different event types
- [`quiet-mode.json`](quiet-mode.json) - Reduced frequency notifications
- [`verbose-mode.json`](verbose-mode.json) - Detailed notifications with context

## Usage

1. Choose an example that fits your needs
2. Copy the configuration to your `~/.claude/settings.json`
3. Update the file paths to match your installation directory
4. Restart Claude Code

## Customization

All examples can be mixed and matched. The hook system allows you to:

- Combine multiple matchers: `"matcher": "Bash|Edit|Write"`
- Use different commands for different events
- Configure selective notifications per tool type
- Set up different voice configurations per event

Feel free to modify these examples to suit your specific workflow!