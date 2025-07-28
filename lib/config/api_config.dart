// class ApiConfig {
//   // For local development with Android emulator
//   static const String localhost = '10.0.2.2'; // Android emulator localhost
//   static const String localhostWeb = 'localhost'; // Web localhost

//   // For physical device, use your computer's IP address
//   static const String computerIP = '10.0.2.2'; // Android emulator localhost

//   // For deployed backend
//   static const String deployedUrl =
//       'https://your-app-name.onrender.com'; // Change to your deployed URL

//   // Current environment
//   static const bool isDevelopment =
//       true; // Set to false when using deployed backend

//   // Get the appropriate base URL
//   static String get baseUrl {
//     if (isDevelopment) {
//       // Use localhost for development (web)
//       return 'http://localhost:8000';
//     } else {
//       // Use deployed URL for production
//       return deployedUrl;
//     }
//   }

//   // Get base URL for web
//   static String get baseUrlWeb {
//     if (isDevelopment) {
//       return 'http://$localhostWeb:8000';
//     } else {
//       return deployedUrl;
//     }
//   }

//   // Get base URL for mobile
//   static String get baseUrlMobile {
//     if (isDevelopment) {
//       return 'http://$computerIP:8000'; // Use your computer's IP for physical device
//     } else {
//       return deployedUrl;
//     }
//   }
// }
class ApiConfig {
  // رابط الباك إند المنشور على Railway
  static const String deployedUrl =
      'https://vidrush-app-production.up.railway.app';

  // استخدم false علشان نشتغل على نسخة production الحقيقية
  static const bool isDevelopment = false;

  static String get baseUrl {
    return deployedUrl;
  }

  static String get baseUrlWeb {
    return deployedUrl;
  }

  static String get baseUrlMobile {
    return deployedUrl;
  }
}
