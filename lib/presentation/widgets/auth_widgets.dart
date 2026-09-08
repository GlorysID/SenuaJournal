import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ── Animated background glowing orbs ──────────────────────────────────────────
class AuthBackgroundOrbs extends StatelessWidget {
  final Animation<double> floatAnim;
  const AuthBackgroundOrbs({super.key, required this.floatAnim});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatAnim,
      builder: (context, _) => Stack(
        children: [
          Positioned(
            top: -60 + floatAnim.value,
            right: -60,
            child: const GlowOrb(size: 220, opacity: 0.20),
          ),
          Positioned(
            bottom: -80 - floatAnim.value,
            left: -40,
            child: const GlowOrb(size: 180, opacity: 0.12),
          ),
          Positioned(
            top: 180 + floatAnim.value * 0.4,
            right: 20,
            child: const GlowOrb(size: 70, opacity: 0.10),
          ),
        ],
      ),
    );
  }
}

class GlowOrb extends StatelessWidget {
  final double size;
  final double opacity;
  const GlowOrb({super.key, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accentColor.withValues(alpha: opacity),
            AppTheme.accentColor.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

// ── App logo badge with glow ───────────────────────────────────────────────────
class AuthLogoBadge extends StatelessWidget {
  const AuthLogoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.accentColor.withValues(alpha: 0.55),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentColor.withValues(alpha: 0.28),
                blurRadius: 28,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Icon(
            Icons.candlestick_chart_rounded,
            color: AppTheme.accentColor,
            size: 42,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'TRADING JOURNAL',
          style: TextStyle(
            color: AppTheme.accentColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.5,
          ),
        ),
      ],
    );
  }
}

// ── Neon-styled text field ─────────────────────────────────────────────────────
class NeonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const NeonTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38, fontSize: 14),
        errorStyle: const TextStyle(color: AppTheme.errorColor, fontSize: 11.5),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(icon, color: AppTheme.accentColor, size: 20),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF181818),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.accentColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppTheme.errorColor, width: 1.5),
        ),
      ),
    );
  }
}

// ── Neon glowing primary button ────────────────────────────────────────────────
class NeonButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  const NeonButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: enabled
                ? AppTheme.accentColor.withValues(alpha: _pressed ? 0.85 : 1.0)
                : AppTheme.accentColor.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(16),
            boxShadow: enabled && !_pressed
                ? [
                    BoxShadow(
                      color: AppTheme.accentColor.withValues(alpha: 0.4),
                      blurRadius: 22,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    widget.label,
                    style: TextStyle(
                      color: enabled ? Colors.black : Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Small icon back button ─────────────────────────────────────────────────────
class AuthBackButton extends StatefulWidget {
  final VoidCallback onPressed;
  const AuthBackButton({super.key, required this.onPressed});

  @override
  State<AuthBackButton> createState() => _AuthBackButtonState();
}

class _AuthBackButtonState extends State<AuthBackButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _pressed
                ? AppTheme.secondaryColor.withValues(alpha: 0.7)
                : AppTheme.secondaryColor,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.09),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white70,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class PremiumGoogleButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const PremiumGoogleButton({super.key, this.onPressed, this.isLoading = false});

  @override
  State<PremiumGoogleButton> createState() => _PremiumGoogleButtonState();
}

class _PremiumGoogleButtonState extends State<PremiumGoogleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled
          ? (_) {
              setState(() => _pressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
              if (_pressed)
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: widget.isLoading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF4285F4),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.network(
                          'https://www.gstatic.com/images/branding/product/2x/googleg_96dp.png',
                          width: 28,
                          height: 28,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.g_mobiledata_rounded,
                                  color: Color(0xFF4285F4), size: 32),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Color(0xFF1F1F1F),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
