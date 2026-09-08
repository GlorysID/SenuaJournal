import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with TickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

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
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _register() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Password tidak cocok');
      return;
    }

    await ref
        .read(authProvider.notifier)
        .register(_usernameController.text.trim(), _passwordController.text);

    if (!mounted) return;
    final state = ref.read(authProvider);
    if (state.hasError) {
      _showError(state.error.toString().replaceAll('Exception: ', ''));
    } else if (state.value != null) {
      Navigator.pushReplacementNamed(context, AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Animated background glow orbs
          AuthBackgroundOrbs(floatAnim: _floatAnim),

          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) => Opacity(
                opacity: _fadeAnim.value,
                child: Transform.translate(
                  offset: Offset(0, _slideAnim.value),
                  child: child,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 28.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      AuthBackButton(onPressed: () => Navigator.pop(context)),
                      const SizedBox(height: 28),

                      // Floating logo
                      Center(
                        child: AnimatedBuilder(
                          animation: _floatAnim,
                          builder: (context, child) => Transform.translate(
                            offset: Offset(0, _floatAnim.value),
                            child: child,
                          ),
                          child: const AuthLogoBadge(),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Headline
                      const Text(
                        'Buat Akun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Mulai catat tradingmu hari ini',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                      const SizedBox(height: 32),

                      // Form card
                      _FormCard(
                        children: [
                          NeonTextField(
                            controller: _usernameController,
                            label: 'Username',
                            icon: Icons.person_outline_rounded,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Username wajib diisi'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          NeonTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            suffixIcon: _TogglePasswordIcon(
                              obscure: _obscurePassword,
                              onToggle: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password wajib diisi';
                              }
                              if (v.length < 6) {
                                return 'Minimal 6 karakter';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          NeonTextField(
                            controller: _confirmPasswordController,
                            label: 'Konfirmasi Password',
                            icon: Icons.lock_reset_rounded,
                            obscureText: _obscureConfirm,
                            suffixIcon: _TogglePasswordIcon(
                              obscure: _obscureConfirm,
                              onToggle: () => setState(
                                () => _obscureConfirm = !_obscureConfirm,
                              ),
                            ),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Wajib diisi' : null,
                          ),
                          const SizedBox(height: 12),

                          // Hint
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: AppTheme.accentColor.withValues(
                                  alpha: 0.55,
                                ),
                                size: 13,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Password minimal 6 karakter',
                                style: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: NeonButton(
                              onPressed: isLoading ? null : _register,
                              isLoading: isLoading,
                              label: 'BUAT AKUN',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Login link
                      Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.pop(context),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 13),
                              children: [
                                TextSpan(
                                  text: 'Sudah punya akun? ',
                                  style: TextStyle(color: Colors.white38),
                                ),
                                TextSpan(
                                  text: 'Masuk',
                                  style: TextStyle(
                                    color: AppTheme.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
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
