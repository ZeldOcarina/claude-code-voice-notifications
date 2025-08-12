import { config } from './config.js';

interface HookEventData {
  hook_event_name: 'Stop' | 'SubagentStop' | 'Notification' | 'PostToolUse';
  session_id?: string;
  transcript_path?: string;
  cwd?: string;
  tool_name?: string;
  tool_input?: any;
  message?: string; // For Notification events
  tool_output?: string; // For PostToolUse events
}

export function generateMessage(eventData: HookEventData): string {
  const { hook_event_name, tool_name, tool_input, message, tool_output } = eventData;
  
  switch (hook_event_name) {
    case 'Stop':
      return config.notifications.stopMessage;
      
    case 'SubagentStop':
      if (tool_name === 'Task') {
        const description = tool_input?.description;
        if (description) {
          return `Subagent finished: ${description.substring(0, 50)}`;
        }
      }
      return config.notifications.subagentStopMessage;
      
    case 'Notification':
      if (message) {
        // Parse common notification messages for more natural speech
        if (message.includes('permission to use')) {
          return 'Claude needs your permission';
        }
        if (message.includes('waiting for your input')) {
          return 'Claude is waiting for your input';
        }
        // For other messages, use a shortened version
        return message.length > 50 ? `${message.substring(0, 50)}...` : message;
      }
      return 'Claude needs your attention';
      
    case 'PostToolUse':
      if (tool_name) {
        // Create contextual messages based on tool type
        switch (tool_name) {
          case 'Bash':
            const command = tool_input?.command;
            if (command) {
              // Check for specific commands that might be important
              if (command.includes('git commit')) {
                return 'Git commit completed';
              }
              if (command.includes('npm install') || command.includes('pnpm install')) {
                return 'Package installation completed';
              }
              if (command.includes('npm run build') || command.includes('pnpm build')) {
                return 'Build completed';
              }
              if (command.includes('test')) {
                return 'Tests completed';
              }
              return `Command completed: ${command.split(' ')[0]}`;
            }
            return 'Command completed';
            
          case 'Edit':
          case 'MultiEdit':
            const filePath = tool_input?.file_path;
            if (filePath) {
              const fileName = filePath.split('/').pop() || 'file';
              return `File edited: ${fileName}`;
            }
            return 'File edited';
            
          case 'Write':
            const writeFilePath = tool_input?.file_path;
            if (writeFilePath) {
              const fileName = writeFilePath.split('/').pop() || 'file';
              return `File created: ${fileName}`;
            }
            return 'File created';
            
          default:
            return `${tool_name} completed`;
        }
      }
      return 'Tool completed';
      
    default:
      return config.notifications.defaultMessage;
  }
}

export function formatDuration(ms?: number): string {
  if (!ms) return '';
  
  const seconds = Math.floor(ms / 1000);
  if (seconds < 60) {
    return `${seconds} seconds`;
  }
  
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  return `${minutes} minutes and ${remainingSeconds} seconds`;
}