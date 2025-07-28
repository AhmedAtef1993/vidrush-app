# Phone Testing Guide

## Issue: App works on emulator but not on physical phone

This is a common network connectivity issue between physical devices and cloud backends.

## Quick Solutions:

### Solution 1: Test Network Access
1. Install the updated APK
2. Tap the **blue WiFi icon** (🌐) to run network tests
3. Check console output for connectivity issues

### Solution 2: Use Local Backend
1. Find your computer's IP address:
   - Windows: Open CMD and type `ipconfig`
   - Look for "IPv4 Address" (usually 192.168.x.x)

2. Update the API config:
   ```dart
   // In lib/config/api_config.dart
   static const String localUrl = 'http://YOUR_COMPUTER_IP:8000';
   static const bool useLocalBackend = true; // Change to true
   ```

3. Start local backend:
   ```bash
   cd backend
   python main.py
   ```

4. Make sure your phone and computer are on the same WiFi network

### Solution 3: Alternative Networks
- Switch from WiFi to Mobile Data
- Try different WiFi networks
- Use a mobile hotspot
- Try using a VPN

### Solution 4: Deploy to Different Platform
If Railway continues to have issues, we can deploy to:
- Render.com
- Heroku
- Vercel
- DigitalOcean

## Testing Steps:
1. Install the updated APK
2. Run network tests (blue WiFi button)
3. Try downloading a video
4. Check console logs for detailed error messages

## Common Error Messages:
- `SocketException`: Network connectivity issue
- `TimeoutException`: Request taking too long
- `HandshakeException`: SSL/TLS issue
- `FormatException`: Response parsing issue 