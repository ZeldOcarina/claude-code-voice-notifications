#!/usr/bin/env node

import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

async function testFallback() {
  const text = "Testing Claude Code voice notification";
  const platform = process.platform;
  
  console.log(`Testing fallback notification on ${platform}...`);
  
  try {
    if (platform === 'darwin') {
      await execAsync(`say "${text}"`);
      console.log('✓ macOS TTS working');
    } else if (platform === 'linux') {
      await execAsync(`notify-send "Claude Code" "${text}"`);
      console.log('✓ Linux notification sent');
    } else if (platform === 'win32') {
      const psScript = `Add-Type -AssemblyName System.Speech; $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.Speak('${text}')`;
      await execAsync(`powershell -Command "${psScript}"`);
      console.log('✓ Windows TTS working');
    } else {
      console.log('Unsupported platform:', platform);
    }
  } catch (error) {
    console.error('Fallback test failed:', error);
  }
}

testFallback();