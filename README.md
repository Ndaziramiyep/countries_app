# Countries App 🌍

A modern Flutter application for browsing and exploring world countries with offline support, favorites, and detailed information.

## Features ✨

- 🔍 **Search Countries** - Real-time search with 500ms debounce
- ⭐ **Favorites** - Save and manage favorite countries
- 📱 **Responsive Design** - Adaptive layout for phones and tablets
- 🌓 **Dark Mode** - Toggle between light and dark themes
- 📡 **Offline Support** - 7-day HTTP caching for offline viewing
- 🎨 **Hero Animations** - Smooth transitions between screens
- 🔄 **Pull to Refresh** - Update country data
- 📊 **Sort Options** - Sort by name or population

## Architecture 🏗️

### Clean Architecture Layers

```
├── presentation/     # UI, Widgets, BLoC
├── domain/          # Entities, Use Cases, Repository Interfaces
├── data/            # Models, Repository Implementations, Data Sources
└── core/            # Network, Theme, Constants, Utilities
```

### Key Patterns

- **BLoC Pattern** - State management with flutter_bloc
- **Dependency Injection** - GetIt service locator
- **Repository Pattern** - Abstract data sources
- **Freezed Models** - Immutable data classes with code generation

## Tech Stack 🛠️

### Core
- Flutter SDK 3.7.2+
- Dart 3.0+

### State Management
- `flutter_bloc` ^8.1.3 - BLoC pattern implementation
- `equatable` ^2.0.5 - Value equality

### Networking & Caching
- `dio` ^5.4.0 - HTTP client
- `dio_cache_interceptor` ^3.5.0 - HTTP caching
- `dio_cache_interceptor_hive_store` ^3.2.2 - Persistent cache storage

### Code Generation
- `freezed` ^2.4.6 - Immutable models
- `json_serializable` ^6.7.1 - JSON parsing
- `build_runner` ^2.4.7 - Code generation runner

### Dependency Injection
- `get_it` ^7.6.4 - Service locator

### Local Storage
- `shared_preferences` ^2.2.2 - Key-value storage
- `path_provider` ^2.1.1 - File system paths

### Utilities
- `dartz` ^0.10.1 - Functional programming (Either type)

## Getting Started 🚀

### Prerequisites

```bash
flutter --version  # Ensure Flutter 3.7.2+
```

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd countries_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

## Project Structure 📁

```
lib/
├── core/
│   ├── constants/          # API endpoints, app constants
│   ├── errors/             # Error handling
│   ├── network/            # HTTP client with caching
│   └── theme/              # App themes (light/dark)
├── di/
│   └── service_locator.dart # Dependency injection setup
├── features/
│   └── countries/
│       ├── data/
│       │   ├── datasources/    # Remote & local data sources
│       │   ├── models/         # Data models (Freezed)
│       │   └── repositories/   # Repository implementations
│       ├── domain/
│       │   ├── entities/       # Business entities
│       │   ├── repositories/   # Repository interfaces
│       │   └── usecases/       # Business logic
│       └── presentation/
│           ├── bloc/           # BLoC (events, states)
│           ├── pages/          # Screen widgets
│           └── widgets/        # Reusable components
└── main.dart                   # App entry point
```

## Key Features Implementation 🔑

### 1. HTTP Caching
- **Strategy**: Cache-first with 7-day expiration
- **Storage**: Hive-based persistent storage
- **Offline**: Automatic fallback to cache on network errors

### 2. Search Debouncing
- **Delay**: 500ms after last keystroke
- **Benefit**: Reduces API calls while typing

### 3. Favorites Management
- **Storage**: SharedPreferences
- **Action**: Click heart icon to toggle (no navigation)

### 4. Hero Animations
- **Element**: Country flags
- **Transition**: List → Detail screen

## API Integration 🌐

**Data Source**: [REST Countries API](https://restcountries.com/)

### Endpoints Used
- `GET /v3.1/all` - All countries
- `GET /v3.1/name/{name}` - Search by name
- `GET /v3.1/alpha/{code}` - Country details by code

## Code Generation 🔧

This project uses code generation for models. After modifying any `@freezed` classes:

```bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes (development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Testing 🧪

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Building 📦

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Performance Optimizations ⚡

- ✅ HTTP response caching (7-day TTL)
- ✅ Search debouncing (500ms)
- ✅ Lazy loading with GetIt
- ✅ Efficient list rendering with GridView.builder
- ✅ Image caching via network image cache
- ✅ Immutable state with Freezed

## Contributing 🤝

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License 📄

This project is licensed under the MIT License.

## Acknowledgments 🙏

- [REST Countries API](https://restcountries.com/) for country data
- Flutter community for excellent packages

---

**Built with ❤️ using Flutter**
