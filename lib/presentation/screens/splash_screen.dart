import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // allow initial read
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAsync();
    });
  }

  Future<void> _checkAuthAsync() async {
    // Wait briefly for effects
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    final authState = ref.read(authProvider);
    if (!authState.isLoading) {
      if (authState.hasValue && authState.value != null) {
        Navigator.pushReplacementNamed(context, AppRouter.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRouter.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if (!next.isLoading) {
        if (next.hasValue && next.value != null) {
          Navigator.pushReplacementNamed(context, AppRouter.home);
        } else {
          Navigator.pushReplacementNamed(context, AppRouter.login);
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppTheme.accentColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SenuaTrade',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.accentColor,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            CircularProgressIndicator(
              color: AppTheme.accentColor.withValues(alpha: 0.5),
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
