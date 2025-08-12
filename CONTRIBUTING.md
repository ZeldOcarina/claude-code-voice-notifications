# 🤝 Contributing to Claude Code Voice Notifications

Thank you for your interest in contributing! This project welcomes contributions from developers of all skill levels.

## 🚀 Quick Start

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/yourusername/claude-code-voice-notifications.git
   cd claude-code-voice-notifications
   ```
3. **Install dependencies**:
   ```bash
   pnpm install
   ```
4. **Test the setup**:
   ```bash
   pnpm test:fallback
   ```

## 🛠️ Development Workflow

### Setting Up Development Environment

1. **Create a `.env` file** (for testing with ElevenLabs):
   ```bash
   cp .env.example .env
   # Add your ElevenLabs API key (optional for development)
   ```

2. **Run tests to ensure everything works**:
   ```bash
   pnpm test              # Test basic functionality
   pnpm test:fallback     # Test system TTS (no API key needed)
   pnpm build             # Test TypeScript compilation
   ```

### Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our coding standards:
   - Write TypeScript with proper types
   - Add error handling for new features
   - Follow existing code patterns
   - Add tests for new functionality

3. **Test your changes**:
   ```bash
   pnpm build             # Ensure TypeScript compiles
   pnpm test:fallback     # Test fallback functionality
   # Test your specific changes
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

## 📝 Contribution Guidelines

### Code Style

- **TypeScript**: Use proper types, avoid `any` when possible
- **Error Handling**: Always handle errors gracefully with fallbacks
- **Comments**: Add JSDoc comments for public functions
- **Formatting**: Code is automatically formatted (consider adding Prettier)

### Commit Messages

Follow conventional commit format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `refactor:` for code refactoring
- `test:` for adding tests
- `chore:` for maintenance tasks

Examples:
```
feat: add support for Google Cloud TTS provider
fix: handle network timeout errors in TTS service
docs: update README with new voice configuration options
```

### Pull Request Process

1. **Ensure your PR**:
   - Has a clear title and description
   - References any related issues
   - Includes tests for new functionality
   - Updates documentation if needed

2. **PR Template** (created automatically):
   - Description of changes
   - Testing performed
   - Breaking changes (if any)
   - Related issues

3. **Review process**:
   - All tests must pass
   - Code review from maintainers
   - Documentation updates if needed

## 🎯 Areas for Contribution

### 🔥 High Priority
- **New TTS Providers**: Google Cloud TTS, AWS Polly, Azure Speech
- **Additional Hook Events**: PreCompact, UserPromptSubmit support
- **Error Recovery**: Better handling of API failures
- **Performance**: Optimize startup time and memory usage

### 🚀 Feature Ideas
- **Voice Personalities**: Different voices for different event types
- **Notification Channels**: Slack, Discord, email integration
- **Smart Filtering**: AI-powered notification filtering
- **Voice Commands**: Voice control for Claude Code
- **Mobile Notifications**: Push notifications to mobile devices

### 🧹 Maintenance
- **Testing**: Expand test coverage
- **Documentation**: More examples and use cases
- **CI/CD**: GitHub Actions for automated testing
- **Accessibility**: Screen reader compatibility

## 🔧 Technical Architecture

### Project Structure
```
src/
├── hook-handler.ts    # Main entry point for hooks
├── tts-service.ts     # TTS provider abstraction
├── messages.ts        # Message generation logic
├── config.ts          # Configuration management
└── test-fallback.ts   # Fallback testing utility

examples/              # Configuration examples
docs/                  # Additional documentation
```

### Key Components

- **TTS Service**: Abstraction layer for different TTS providers
- **Message Generator**: Creates contextual messages based on hook data
- **Hook Handler**: Processes Claude Code hook events
- **Fallback System**: Ensures notifications always work

### Adding New TTS Providers

1. **Extend TTSService interface**:
   ```typescript
   interface TTSProvider {
     speak(text: string): Promise<void>;
   }
   ```

2. **Implement provider class**:
   ```typescript
   export class GoogleTTSService implements TTSProvider {
     async speak(text: string): Promise<void> {
       // Implementation
     }
   }
   ```

3. **Add configuration options**
4. **Update documentation and examples**

## 🐛 Bug Reports

### Before Submitting
- Check existing issues to avoid duplicates
- Test with fallback mode: `pnpm test:fallback`
- Gather system information (OS, Node.js version, etc.)

### Bug Report Template
```markdown
**Describe the bug**
A clear description of the bug.

**To Reproduce**
Steps to reproduce the behavior.

**Expected behavior**
What you expected to happen.

**Environment:**
- OS: [e.g., macOS 14.0]
- Node.js: [e.g., 20.0.0]
- Claude Code version: [e.g., 1.2.3]

**Additional context**
Any other context about the problem.
```

## 💡 Feature Requests

We love new ideas! When suggesting features:

1. **Check existing issues** for similar requests
2. **Provide context** - what problem does this solve?
3. **Consider implementation** - how might this work?
4. **Think about scope** - does this fit the project goals?

## 🆘 Getting Help

- **Discussions**: Use GitHub Discussions for questions
- **Issues**: Create issues for bugs and feature requests
- **Documentation**: Check README and examples first

## 🏆 Recognition

Contributors are recognized in:
- README acknowledgments
- Release notes
- GitHub contributor graphs

Thank you for helping make Claude Code Voice Notifications better! 🎉

## 📋 Development Checklist

Before submitting a PR, ensure:

- [ ] Code compiles without errors (`pnpm build`)
- [ ] All tests pass (`pnpm test:fallback`)
- [ ] New features have tests
- [ ] Documentation is updated
- [ ] Commit messages follow conventional format
- [ ] No breaking changes (or clearly documented)
- [ ] Works on different platforms (if applicable)

---

**Happy Contributing!** 🚀