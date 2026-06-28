import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:punggawa_motor_manager/core/theme/app_theme.dart';
import 'package:punggawa_motor_manager/core/constants/app_strings.dart';
import 'package:punggawa_motor_manager/core/routes/app_routes.dart';
import 'package:punggawa_motor_manager/screens/splash/splash_screen.dart';

/// Main Entry Point untuk Punggawa Motor Manager
/// 
/// Konfigurasi:
/// - Material Design 3 Theme
/// - Riverpod State Management
/// - Splash Screen sebagai initial route
/// - Firebase integration ready
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // TODO: Inisialisasi Firebase
  // await FirebaseService.initializeFirebase();
  
  runApp(const ProviderScope(child: MyApp()));
}

/// Root Widget untuk Aplikasi
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Konfigurasi umum
      title: AppStrings.shopName,
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme(),
      
      // Initial route
      home: const SplashScreen(),
      
      // Named routes (optional)
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        // AppRoutes.login: (_) => const LoginScreen(),
        // AppRoutes.dashboard: (_) => const DashboardScreen(),
      },
    );
  }
}
