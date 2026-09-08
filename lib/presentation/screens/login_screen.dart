import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late final AnimationController _fadeController;
  late final AnimationController _floatController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _slideAnim;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideAnim = Tween<double>(begin: 36, end: 0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );
    _floatAnim = Tween<double>(begin: -7, end: 7).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }


  void _loginWithGoogle() async {
    FocusScope.of(context).unfocus();
    await ref.read(authProvider.notifier).signInWithGoogle();
    if (!mounted) return;
    final state = ref.read(authProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString().replaceAll('Exception: ', '')),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if (!next.isLoading && next.hasValue && next.value != null) {
        Navigator.pushReplacementNamed(context, AppRouter.home);
      }
    });

    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Extra dark background
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Gradient Orbs
          AuthBackgroundOrbs(floatAnim: _floatAnim),
          
          // Subtle radial glow from bottom
          Positioned(
            bottom: -150,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppTheme.accentColor.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Large Animated Logo
                    AnimatedBuilder(
                      animation: _floatAnim,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(0, _floatAnim.value),
                        child: child,
                      ),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AppTheme.accentColor.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.accentColor.withValues(alpha: 0.15),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Titles
                    const Text(
                      'SenuaTrade',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Elevate your trading with data-driven insights',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 64),

                    // Login Card (Glassmorphism)
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'SYNC YOUR ACCOUNT',
                            style: TextStyle(
                              color: AppTheme.accentColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Access your trades and strategies anywhere by signing in with Google',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          PremiumGoogleButton(
                            onPressed: isLoading ? null : _loginWithGoogle,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Terms/Privacy subtle note
                    const Text(
                      'By continuing, you agree to our Terms of Service',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared sub-widgets ──────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final List<Widget> children;
  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppTheme.accentColor.withValues(alpha: 0.13),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor.withValues(alpha: 0.06),
            blurRadius: 32,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _TogglePasswordIcon extends StatelessWidget {
  final bool obscure;
  final VoidCallback onToggle;
  const _TogglePasswordIcon({required this.obscure, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: Colors.white38,
        size: 20,
      ),
      onPressed: onToggle,
      splashRadius: 20,
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _GoogleSignInButton({this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white.withValues(alpha: 0.03),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://www.gstatic.com/images/branding/product/2x/googleg_96dp.png',
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
