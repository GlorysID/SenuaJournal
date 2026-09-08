import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/auth_widgets.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _savePassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_newController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New passwords do not match'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref
          .read(authProvider.notifier)
          .changePassword(_currentController.text, _newController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Security',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Update your password to stay secure.',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppTheme.accentColor.withValues(alpha: 0.13),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      NeonTextField(
                        controller: _currentController,
                        label: 'Current Password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: _obscureCurrent,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureCurrent
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white38,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _obscureCurrent = !_obscureCurrent,
                          ),
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      NeonTextField(
                        controller: _newController,
                        label: 'New Password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: _obscureNew,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNew
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white38,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscureNew = !_obscureNew),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          if (v.length < 6) return 'Minimum 6 characters';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      NeonTextField(
                        controller: _confirmController,
                        label: 'Confirm New Password',
                        icon: Icons.lock_reset_rounded,
                        obscureText: _obscureConfirm,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.white38,
                            size: 20,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: NeonButton(
                          onPressed: _isLoading ? null : _savePassword,
                          isLoading: _isLoading,
                          label: 'UPDATE PASSWORD',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
