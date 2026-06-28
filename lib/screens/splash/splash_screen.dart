import 'package:flutter/material.dart';
import 'package:punggawa_motor_manager/core/constants/app_colors.dart';
import 'package:punggawa_motor_manager/core/constants/app_dimensions.dart';
import 'package:punggawa_motor_manager/core/constants/app_strings.dart';
import 'package:punggawa_motor_manager/core/routes/app_routes.dart';
import 'package:punggawa_motor_manager/screens/login/login_screen.dart';

/// Splash Screen untuk Punggawa Motor Manager
/// 
/// Menampilkan:
/// - Logo dengan animasi Fade In (800ms)
/// - Scale Animation setelah Fade In
/// - Nama aplikasi dan subtitle
/// - Version number
/// - Total durasi 3 detik sebelum navigasi ke Login Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToLogin();
  }

  /// Inisialisasi animasi Fade In dan Scale
  void _initializeAnimations() {
    // Fade In Animation Controller (800ms)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Scale Animation Controller (dimulai setelah Fade In selesai)
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Mulai Fade Animation
    _fadeController.forward().then((_) {
      // Setelah Fade selesai, mulai Scale Animation
      _scaleController.forward();
    });
  }

  /// Navigasi ke Login Screen setelah 3 detik
  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan Fade In dan Scale Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXl,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryDark.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.two_wheeler,
                        color: AppColors.white,
                        size: 64,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXl),

                // Application Name
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    AppStrings.shopName,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.primaryDark,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSm),

                // Subtitle
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Motorcycle Workshop Management System',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          // Version di bagian bawah
          Positioned(
            bottom: AppDimensions.paddingLg,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
