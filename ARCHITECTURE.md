# Architecture Documentation

## Overview

This application follows **Clean Architecture** principles with clear separation of concerns across three main layers: Presentation, Domain, and Data.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │  Pages   │  │ Widgets  │  │  BLoC (State Mgmt)   │  │
│  └──────────┘  └──────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓ ↑
┌─────────────────────────────────────────────────────────┐
│                      DOMAIN LAYER                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │ Entities │  │ Use Cases│  │ Repository Interface │  │
│  └──────────┘  └──────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓ ↑
┌─────────────────────────────────────────────────────────┐
│                       DATA LAYER                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │  Models  │  │Repository│  │    Data Sources      │  │
│  │          │  │   Impl   │  │  (Remote & Local)    │  │
│  └──────────┘  └──────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓ ↑
┌─────────────────────────────────────────────────────────┐
│                       CORE LAYER                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────────┐  │
│  │ Network  │  │  Theme   │  │     Constants        │  │
│  └──────────┘  └──────────┘  └──────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Layer Responsibilities

### 1. Presentation Layer
**Location**: `lib/features/countries/presentation/`

**Responsibilities**:
- Display UI to users
- Handle user interactions
- Manage UI state with BLoC
- Navigate between screens

**Components**:
- **Pages**: Full screen widgets (HomePage, CountryDetailPage, FavoritesPage)
- **Widgets**: Reusable UI components (CountryCard, SearchBar, LoadingShimmer)
- **BLoC**: State management (CountriesBloc, CountriesEvent, CountriesState)

**Dependencies**: Domain layer only (use cases)

### 2. Domain Layer
**Location**: `lib/features/countries/domain/`

**Responsibilities**:
- Define business logic
- Define core entities
- Define repository contracts
- Independent of frameworks

**Components**:
- **Entities**: Pure Dart classes (Country)
- **Use Cases**: Business operations (GetAllCountries, SearchCountries, GetCountryDetails, ManageFavorites)
- **Repository Interfaces**: Abstract contracts for data access

**Dependencies**: None (pure Dart)

### 3. Data Layer
**Location**: `lib/features/countries/data/`

**Responsibilities**:
- Implement repository interfaces
- Handle data transformation
- Manage data sources (API, local storage)
- Cache management

**Components**:
- **Models**: Data transfer objects with JSON serialization (CountrySummaryModel, CountryDetailModel)
- **Repositories**: Implementation of domain contracts (CountriesRepositoryImpl)
- **Data Sources**: 
  - Remote: API calls (CountriesRemoteDataSource)
  - Local: SharedPreferences (CountriesLocalDataSource)

**Dependencies**: Domain layer

### 4. Core Layer
**Location**: `lib/core/`

**Responsibilities**:
- Shared utilities
- Network configuration
- App-wide constants
- Theme configuration

**Components**:
- **Network**: HTTP client with caching (DioClient)
- **Theme**: Light and dark themes
- **Constants**: API endpoints, app constants
- **Errors**: Exception handling

## Design Patterns

### 1. BLoC Pattern
**Purpose**: Separate business logic from UI

```dart
// Event
class LoadAllCountries extends CountriesEvent {}

// State
class CountriesLoaded extends CountriesState {
  final List<Country> countries;
  final Set<String> favorites;
}

// BLoC
class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  // Handles events and emits states
}
```

### 2. Repository Pattern
**Purpose**: Abstract data sources

```dart
// Interface (Domain)
abstract class CountriesRepository {
  Future<Either<Failure, List<Country>>> getAllCountries();
}

// Implementation (Data)
class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource remoteDataSource;
  final CountriesLocalDataSource localDataSource;
  // Implementation details
}
```

### 3. Dependency Injection
**Purpose**: Loose coupling and testability

```dart
// Service Locator (GetIt)
sl.registerFactory(() => CountriesBloc(
  getAllCountries: sl(),
  searchCountries: sl(),
));

sl.registerLazySingleton(() => GetAllCountries(sl()));
```

### 4. Use Case Pattern
**Purpose**: Single responsibility for business operations

```dart
class GetAllCountries {
  final CountriesRepository repository;
  
  Future<Either<Failure, List<Country>>> call() {
    return repository.getAllCountries();
  }
}
```

## Data Flow

### Example: Loading Countries

```
1. User opens app
   ↓
2. HomePage triggers LoadAllCountries event
   ↓
3. CountriesBloc receives event
   ↓
4. BLoC calls GetAllCountries use case
   ↓
5. Use case calls CountriesRepository
   ↓
6. Repository checks cache (DioClient)
   ↓
7. If cache miss, calls RemoteDataSource
   ↓
8. RemoteDataSource fetches from API
   ↓
9. Data flows back through layers
   ↓
10. BLoC emits CountriesLoaded state
   ↓
11. UI rebuilds with new data
```

## State Management Flow

```
┌──────────┐
│   UI     │ Dispatches Event
└────┬─────┘
     │
     ↓
┌──────────┐
│   BLoC   │ Processes Event
└────┬─────┘
     │
     ↓
┌──────────┐
│ Use Case │ Executes Business Logic
└────┬─────┘
     │
     ↓
┌──────────┐
│Repository│ Fetches Data
└────┬─────┘
     │
     ↓
┌──────────┐
│   BLoC   │ Emits New State
└────┬─────┘
     │
     ↓
┌──────────┐
│   UI     │ Rebuilds
└──────────┘
```

## Caching Strategy

### HTTP Caching (dio_cache_interceptor)
- **Policy**: CachePolicy.forceCache (cache-first)
- **Duration**: 7 days (maxStale)
- **Storage**: HiveCacheStore (persistent)
- **Fallback**: Use cache on network errors (except 401, 403)

### Benefits:
- ✅ Reduced API calls
- ✅ Offline support
- ✅ Faster load times
- ✅ Lower data usage

## Error Handling

### Either Type (dartz)
```dart
// Success
return Right(countries);

// Failure
return Left(ServerFailure());
```

### Exception Hierarchy
```
Exception
├── ServerException (API errors)
├── CacheException (Local storage errors)
└── NetworkException (Connectivity issues)
```

## Testing Strategy

### Unit Tests
- Use cases
- BLoC logic
- Repository implementations

### Widget Tests
- Individual widgets
- Page layouts
- User interactions

### Integration Tests
- End-to-end flows
- API integration
- State management

## Scalability Considerations

### Adding New Features
1. Create new feature folder in `features/`
2. Follow same layer structure
3. Register dependencies in service locator
4. Keep features independent

### Adding New Data Sources
1. Create interface in domain layer
2. Implement in data layer
3. Register in dependency injection
4. Update repository to use new source

### Performance Optimization
- ✅ Lazy loading with GetIt
- ✅ Efficient list rendering (GridView.builder)
- ✅ Image caching
- ✅ HTTP response caching
- ✅ Debounced search
- ✅ Immutable state (Freezed)

## Code Generation

### Freezed Models
```dart
@freezed
class CountryDetailModel with _$CountryDetailModel {
  const factory CountryDetailModel({
    required String name,
    // ... other fields
  }) = _CountryDetailModel;
  
  factory CountryDetailModel.fromJson(Map<String, dynamic> json);
}
```

**Generated**:
- Immutable classes
- copyWith method
- == and hashCode
- toString
- JSON serialization

## Best Practices

### 1. Separation of Concerns
- Each layer has single responsibility
- No direct dependencies between presentation and data

### 2. Dependency Rule
- Dependencies point inward (toward domain)
- Domain layer has no external dependencies

### 3. Immutability
- Use Freezed for immutable models
- Use const constructors where possible

### 4. Type Safety
- Use Either for error handling
- Avoid dynamic types
- Leverage Dart's type system

### 5. Documentation
- Document public APIs
- Explain complex logic
- Keep comments up-to-date

## Future Enhancements

### Potential Improvements
- [ ] Add unit tests
- [ ] Add widget tests
- [ ] Implement pagination
- [ ] Add more filter options
- [ ] Support multiple languages
- [ ] Add country comparison feature
- [ ] Implement analytics
- [ ] Add accessibility features

---

**Last Updated**: 2024
