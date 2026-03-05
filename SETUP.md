# Countries App - Setup Instructions

## Prerequisites

### Required Software
- **Flutter SDK**: 3.7.2 or higher
- **Dart SDK**: 3.0 or higher
- **Android Studio** (for Android development) or **Xcode** (for iOS development)
- **Git** (for cloning the repository)

### Check Flutter Installation
```bash
flutter --version
flutter doctor
```

## Installation Steps

### 1. Clone the Repository
```bash
git clone <repository-url>
cd countries_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code (Freezed Models)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the App

#### For Development (Debug Mode)
```bash
flutter run
```

#### For Android Device/Emulator
```bash
flutter run -d android
```

#### For iOS Device/Simulator (macOS only)
```bash
flutter run -d ios
```

## Building Release APK/IPA

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS (macOS only)
```bash
flutter build ios --release
```

## Project Configuration

### Minimum Requirements
- **Android**: minSdk 21 (Android 5.0+)
- **iOS**: iOS 12.0+
- **Internet Connection**: Required for API calls

### API Used
- **REST Countries API**: https://restcountries.com/v3.1/
- No API key required
- Free and open source

## Key Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3          # State management
  dio: ^5.4.0                   # HTTP client
  dio_cache_interceptor: ^3.5.0 # HTTP caching
  shared_preferences: ^2.2.2    # Local storage
  get_it: ^7.6.4                # Dependency injection
  equatable: ^2.0.5             # Value equality
  dartz: ^0.10.1                # Functional programming
  freezed_annotation: ^2.4.1    # Code generation

dev_dependencies:
  build_runner: ^2.4.7          # Code generation
  freezed: ^2.4.6               # Immutable models
  flutter_launcher_icons: ^0.13.1 # App icon generation
```

## Troubleshooting

### Issue: "No implementation found for method"
**Solution**: Run `flutter clean` then `flutter pub get`

### Issue: "Build failed with an exception"
**Solution**: 
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### Issue: "Gradle build failed"
**Solution**: 
- Ensure Android SDK is properly installed
- Check `android/local.properties` has correct SDK path
- Run `flutter doctor` to check setup

### Issue: App crashes on startup
**Solution**: 
- Check internet connection
- Ensure all dependencies are installed
- Run `flutter clean` and rebuild

## Features

✅ Browse all countries  
✅ Search countries with debounce (500ms)  
✅ View detailed country information  
✅ Add/remove favorites  
✅ Offline caching (7 days)  
✅ Bottom navigation (Home/Favorites)  
✅ Hero animations on flags  
✅ Dark mode support  
✅ Responsive design (phone/tablet)  

## Architecture

- **Clean Architecture** (Presentation, Domain, Data layers)
- **BLoC Pattern** for state management
- **Repository Pattern** for data access
- **Dependency Injection** with GetIt
- **Freezed** for immutable models

## Project Structure

```
lib/
├── core/                 # Shared utilities
│   ├── constants/       # API endpoints, constants
│   ├── network/         # HTTP client
│   └── theme/           # App themes
├── di/                  # Dependency injection
├── features/
│   └── countries/
│       ├── data/        # Models, repositories, data sources
│       ├── domain/      # Entities, use cases
│       └── presentation/# UI, BLoC, widgets
└── main.dart           # App entry point
```

## Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Additional Notes

- **No environment variables** required
- **No API keys** needed
- **Internet permission** already configured in AndroidManifest.xml
- **App icon** can be customized in `assets/icon/Icon.png`

## Support

For issues or questions:
1. Check `flutter doctor` output
2. Ensure Flutter SDK is up to date
3. Verify all dependencies are installed
4. Check internet connection for API calls

---

**Last Updated**: 2024  
**Flutter Version**: 3.7.2+  
**Dart Version**: 3.0+
