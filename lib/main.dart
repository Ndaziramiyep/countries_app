import 'package:flutter/material.dart';
import 'di/service_locator.dart' as di;
import 'features/countries/presentation/pages/main_navigation_page.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await di.init();
  } catch (e) {
    debugPrint('Error initializing dependencies: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationPage(),
    );
  }
}
