import 'package:flutter/material.dart';
import 'package:punggawa_motor_manager/core/constants/app_colors.dart';
import 'package:punggawa_motor_manager/core/constants/app_dimensions.dart';
import 'package:punggawa_motor_manager/core/constants/app_strings.dart';
import 'package:punggawa_motor_manager/core/utils/validators.dart';

/// Login Screen untuk Punggawa Motor Manager
/// 
/// Fitur:
/// - Login dengan Email dan Password
/// - Firebase Authentication
/// - Form validation
/// - Lupa Password
/// - Remember Me checkbox
/// - Fade & Slide animation
/// - Material Design 3 styling
/// - Responsive design
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _initializeAnimations();
  }

  /// Inisialisasi animasi Fade dan Slide
  void _initializeAnimations() {
    // Fade Animation Controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Slide Animation Controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    // Mulai animasi
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  /// Handle login process dengan Firebase Authentication
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implementasi Firebase Authentication
      // final userCredential = await FirebaseService.auth.signInWithEmailAndPassword(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text,
      // );

      // Simulasi delay untuk demo
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 2),
          ),
        );

        // TODO: Navigate to Dashboard
        // Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login gagal: $e'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Navigate to forgot password screen
  void _handleForgotPassword() {
    // TODO: Implementasi forgot password screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur Lupa Password akan segera tersedia'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLg,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppDimensions.paddingLg),

                    // Logo Section
                    _buildLogoSection(context),
                    const SizedBox(height: AppDimensions.paddingXl),

                    // Email Field
                    _buildEmailField(),
                    const SizedBox(height: AppDimensions.paddingMd),

                    // Password Field
                    _buildPasswordField(),
                    const SizedBox(height: AppDimensions.paddingMd),

                    // Remember Me & Forgot Password Row
                    _buildRememberAndForgotRow(),
                    const SizedBox(height: AppDimensions.paddingXl),

                    // Login Button
                    _buildLoginButton(),
                    const SizedBox(height: AppDimensions.paddingXl),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build logo section dengan judul dan subtitle
  Widget _buildLogoSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Logo Container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryDark.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.two_wheeler,
              color: AppColors.white,
              size: 56,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMd),

          // App Name
          Text(
            AppStrings.shopName,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.primaryDark,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSm),

          // Subtitle
          Text(
            'Workshop Management System',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Build email field
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email Anda',
        prefixIcon: const Icon(Icons.email_outlined),
        prefixIconColor: AppColors.primaryDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      textInputAction: TextInputAction.next,
    );
  }

  /// Build password field dengan show/hide button
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) => Validators.validatePassword(value),
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: AppStrings.password,
        hintText: 'Masukkan password Anda',
        prefixIcon: const Icon(Icons.lock_outlined),
        prefixIconColor: AppColors.primaryDark,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.primaryDark,
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
      textInputAction: TextInputAction.done,
    );
  }

  /// Build remember me checkbox dan forgot password link
  Widget _buildRememberAndForgotRow() {
    return Row(
      children: [
        // Remember Me Checkbox
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() => _rememberMe = value ?? false);
                },
                activeColor: AppColors.primaryDark,
                side: const BorderSide(color: AppColors.primaryDark),
              ),
              Text(
                'Ingat Saya',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Forgot Password Button
        TextButton(
          onPressed: _handleForgotPassword,
          child: Text(
            AppStrings.forgotPassword,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Build login button
  Widget _buildLoginButton() {
    return SizedBox(
      height: AppDimensions.buttonHeight,
      child: FilledButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          disabledBackgroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            )
            : Text(
              AppStrings.login.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
      ),
    );
  }
}
