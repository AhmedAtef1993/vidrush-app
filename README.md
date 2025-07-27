# 🎬 VidRush - Video Downloader App

A modern, feature-rich mobile application for downloading videos from popular platforms like YouTube, TikTok, Instagram, and more.

## ✨ Features

- **🎯 Multi-Platform Support**: Download from YouTube, TikTok, Instagram, Facebook, and more
- **🎨 Modern UI**: Beautiful, responsive design with dark/light mode
- **⚡ Real-time Progress**: Live download progress tracking
- **📱 Mobile-First**: Optimized for Android and iOS
- **🔧 Backend Integration**: FastAPI + yt-dlp for reliable downloads
- **🌐 Cross-Platform**: Works on web, mobile, and desktop

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.8.1+)
- Python 3.11+
- Android Studio / Xcode (for mobile builds)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/vidrush-app.git
   cd vidrush-app
   ```

2. **Set up the backend:**
   ```bash
   cd backend
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   python main.py
   ```

3. **Run the Flutter app:**
   ```bash
   flutter pub get
   flutter run
   ```

## 📱 App Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── download_screen.dart
│   ├── settings_screen.dart
│   └── video_player_screen.dart
├── widgets/                  # Reusable components
│   ├── background_widget.dart
│   └── custom_bottom_navigation.dart
├── services/                 # Business logic
│   ├── api_service.dart
│   ├── video_download_service.dart
│   └── connection_test.dart
├── providers/                # State management
│   └── theme_provider.dart
└── config/                   # Configuration
    └── api_config.dart
```

## 🔧 Backend API

### Endpoints

- `GET /health` - Health check
- `POST /api/video/info` - Get video metadata
- `POST /api/video/download` - Start download
- `GET /api/download/{id}` - Get download status
- `GET /api/downloads` - List all downloads
- `DELETE /api/download/{id}` - Delete download

### Example Usage

```bash
# Get video info
curl -X POST http://localhost:8000/api/video/info \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}'

# Start download
curl -X POST http://localhost:8000/api/video/download \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}'
```

## 🎨 UI Components

### Screens
- **Splash Screen**: App branding and loading
- **Home Screen**: Video URL input and popular platforms
- **Download Screen**: Download management and progress
- **Settings Screen**: App configuration and theme
- **Video Player**: Video playback interface

### Features
- **Dark/Light Mode**: Automatic theme switching
- **Responsive Design**: Works on all screen sizes
- **Modern Animations**: Smooth transitions and effects
- **Error Handling**: User-friendly error messages

## 📦 Building

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

### Web Build
```bash
flutter build web
```

## 🚀 Deployment

### Backend Deployment
See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed instructions on deploying to Render or Railway.

### Frontend Deployment
1. Update API URL in `lib/config/api_config.dart`
2. Build release APK: `flutter build apk --release`
3. Install on Android device

## 🔧 Configuration

### API Configuration
Edit `lib/config/api_config.dart`:
```dart
static const String deployedUrl = 'https://your-app.onrender.com';
static const bool isDevelopment = false;
```

### Theme Configuration
Edit `lib/providers/theme_provider.dart` to customize colors and styling.

## 🧪 Testing

### Backend Testing
```bash
# Health check
curl http://localhost:8000/health

# Video info test
curl -X POST http://localhost:8000/api/video/info \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"}'
```

### Frontend Testing
1. Run the app: `flutter run`
2. Test video URL input
3. Test download functionality
4. Test theme switching
5. Test error handling

## 🐛 Troubleshooting

### Common Issues

1. **Backend Connection Failed**
   - Check if backend is running on port 8000
   - Verify API URL in configuration
   - Test with curl command

2. **APK Installation Fails**
   - Enable "Install from Unknown Sources"
   - Check Android version compatibility
   - Try debug APK first

3. **Downloads Not Working**
   - Check if yt-dlp is installed
   - Verify file permissions
   - Check backend logs

4. **Font Errors**
   - Fonts are commented out in pubspec.yaml
   - App uses system fonts by default

## 📊 Performance

### Optimizations
- **Lazy Loading**: Images and assets loaded on demand
- **Caching**: Video metadata cached locally
- **Compression**: Backend responses compressed
- **Minification**: Release builds optimized

### Monitoring
- Backend logs in console
- Flutter DevTools for frontend debugging
- Network tab for API calls

## 🔒 Security

### Current Features
- Input validation for URLs
- CORS configuration
- Error handling without exposing internals

### Planned Features
- User authentication
- Rate limiting
- API key management
- File encryption

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **yt-dlp**: Video extraction library
- **FastAPI**: Modern web framework
- **Flutter**: Cross-platform UI framework
- **Material Design**: UI design system

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/vidrush-app/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/vidrush-app/discussions)
- **Email**: support@vidrush-app.com

---

**🎉 Made with ❤️ for video lovers everywhere!**
