import { ElevenLabsClient, play } from '@elevenlabs/elevenlabs-js';
import { config } from './config.js';

export class TTSService {
  private client: ElevenLabsClient | null;
  
  constructor() {
    if (config.elevenLabs.apiKey) {
      this.client = new ElevenLabsClient({
        apiKey: config.elevenLabs.apiKey,
      });
    } else {
      this.client = null;
      console.log('ElevenLabs API key not found. Using fallback TTS.');
    }
  }
  
  async speak(text: string): Promise<void> {
    // If no API key, go straight to fallback
    if (!this.client) {
      await this.fallbackNotification(text);
      return;
    }
    
    try {
      const audio = await this.client.textToSpeech.convert(
        config.elevenLabs.voiceId,
        {
          text,
          modelId: config.elevenLabs.modelId,
          outputFormat: config.elevenLabs.outputFormat,
        }
      );
      
      await play(audio);
    } catch (error) {
      console.error('TTS Error:', error);
      
      await this.fallbackNotification(text);
    }
  }
  
  private async fallbackNotification(text: string): Promise<void> {
    const { exec } = await import('child_process');
    const { promisify } = await import('util');
    const execAsync = promisify(exec);
    
    const platform = process.platform;
    
    try {
      if (platform === 'darwin') {
        await execAsync(`say "${text.replace(/"/g, '\\"')}"`);
      } else if (platform === 'linux') {
        await execAsync(`notify-send "Claude Code" "${text.replace(/"/g, '\\"')}"`);
      } else if (platform === 'win32') {
        const psScript = `Add-Type -AssemblyName System.Speech; $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; $speak.Speak('${text.replace(/'/g, "''")}')`;
        await execAsync(`powershell -Command "${psScript}"`);
      }
    } catch (fallbackError) {
      console.error('Fallback notification failed:', fallbackError);
    }
  }
}