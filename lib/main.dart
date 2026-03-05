/// Countries App - Main Entry Point
/// 
/// A Flutter application for browsing and exploring world countries.
/// Features: Search, favorites, offline caching, and detailed country information.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/service_locator.dart' as di;
import 'features/countries/presentation/bloc/countries_bloc.dart';
import 'features/countries/presentation/bloc/countries_event.dart';
import 'features/countries/presentation/pages/home_page.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/dark_theme.dart';

/// Application entry point
/// Initializes dependencies before running the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

/// Root widget of the application
/// Manages theme mode and provides global BLoC
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  /// Toggles between light and dark theme
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CountriesBloc>()..add(LoadAllCountries()),
      child: MaterialApp(
        title: 'Countries App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: DarkTheme.darkTheme,
        themeMode: _themeMode,
        home: HomePage(onThemeToggle: _toggleTheme),
      ),
    );
  }
}
