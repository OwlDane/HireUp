import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/custom_button.dart';
import '../../../shared/widgets/buttons/social_button.dart';
import '../../../shared/widgets/inputs/custom_text_field.dart';
import '../../../shared/widgets/feedback/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // Logo Container
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientStart,
                              AppColors.gradientEnd,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.work_outline_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Welcome Text
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // Password Field
                    CustomTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 16),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    // Login Button
                    CustomButton(
                      text: 'Sign In',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                    ),
                    
                    const SizedBox(height: 24),
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.textSecondary.withOpacity(0.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.textSecondary.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    // Social Login Buttons
                    SocialButton(
                      iconPath: 'assets/images/google_icon.png',
                      label: 'Continue with Google',
                      onPressed: _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 16),
                    SocialButton(
                      iconPath: 'assets/images/apple_icon.png',
                      label: 'Continue with Apple',
                      onPressed: _handleAppleSignIn,
                    ),
                    
                    const SizedBox(height: 24),
                    // Register Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to register screen
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          CustomSnackbar.showSuccess(
            context: context,
            message: 'Login successful! Welcome back.',
          );
          // Navigate to home screen
        }
      } catch (e) {
        if (mounted) {
          CustomSnackbar.showError(
            context: context,
            message: 'Login failed. Please check your credentials.',
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      // Implement Google Sign In
      CustomSnackbar.show(
        context: context,
        message: 'Google Sign In will be implemented',
      );
    } catch (e) {
      CustomSnackbar.showError(
        context: context,
        message: 'Google Sign In failed',
      );
    }
  }

  Future<void> _handleAppleSignIn() async {
    try {
      // Implement Apple Sign In
      CustomSnackbar.show(
        context: context,
        message: 'Apple Sign In will be implemented',
      );
    } catch (e) {
      CustomSnackbar.showError(
        context: context,
        message: 'Apple Sign In failed',
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}