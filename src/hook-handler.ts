#!/usr/bin/env node

import { generateMessage } from './messages.js';
import { TTSService } from './tts-service.js';

async function readStdin(): Promise<string> {
  const chunks: Buffer[] = [];
  
  return new Promise((resolve, reject) => {
    process.stdin.on('data', (chunk: Buffer) => {
      chunks.push(chunk);
    });
    
    process.stdin.on('end', () => {
      resolve(Buffer.concat(chunks).toString());
    });
    
    process.stdin.on('error', reject);
  });
}

async function main() {
  try {
    const inputData = await readStdin();
    
    if (!inputData.trim()) {
      // No input data - create default event
      const tts = new TTSService();
      await tts.speak('Claude Code notification');
      process.exit(0);
    }
    
    let eventData;
    try {
      eventData = JSON.parse(inputData);
    } catch (parseError) {
      console.error('JSON parse error:', parseError);
      console.error('Input data:', inputData);
      // Fallback to default event
      const tts = new TTSService();
      await tts.speak('Claude Code notification');
      process.exit(0);
    }
    
    const message = generateMessage({
      hook_event_name: eventData.hook_event_name || 'Stop',
      session_id: eventData.session_id,
      transcript_path: eventData.transcript_path,
      cwd: eventData.cwd,
      tool_name: eventData.tool_name,
      tool_input: eventData.tool_input,
      message: eventData.message, // For Notification events
      tool_output: eventData.tool_output, // For PostToolUse events
    });
    
    const tts = new TTSService();
    await tts.speak(message);
    
    process.exit(0);
  } catch (error) {
    console.error('Hook handler error:', error);
    process.exit(1);
  }
}

main();