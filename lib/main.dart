import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/database/isar_service.dart';
import 'presentation/providers/sync_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Database
  final isarService = IsarService();
  await isarService.db;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize Sync Service
    ref.watch(syncProvider);

    // Global navigation listener
    ref.listen(authProvider, (previous, next) {
      if (next.isLoading) return;
      
      final user = next.value;
      if (user == null) {
        // Redirect to Login if signed out
        AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRouter.login,
          (route) => false,
        );
      } else if (previous?.value == null) {
        // Redirect to Home if signed in
        AppRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRouter.home,
          (route) => false,
        );
      }
    });

    final authState = ref.watch(authProvider);

    return MaterialApp(
      navigatorKey: AppRouter.navigatorKey,
      title: 'SenuaTrade',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      home: authState.when(
        data: (user) => user != null ? const HomeScreen() : const LoginScreen(),
        loading: () => const SplashScreen(),
        error: (err, stack) => const LoginScreen(),
      ),
    );
  }
}
