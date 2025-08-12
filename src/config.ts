import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(__dirname, '..', '.env') });

export const config = {
  elevenLabs: {
    apiKey: process.env.ELEVENLABS_API_KEY || '',
    voiceId: process.env.ELEVENLABS_VOICE_ID || 'JBFqnCBsd6RMkjVDRZzb',
    modelId: 'eleven_flash_v2_5',
    outputFormat: 'mp3_44100_128' as const,
  },
  notifications: {
    stopMessage: 'Claude has finished responding.',
    subagentStopMessage: 'Subagent task completed.',
    errorMessage: 'An error occurred in the task.',
    defaultMessage: 'Notification from Claude Code.',
  },
};