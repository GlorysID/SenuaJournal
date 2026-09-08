import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/utils/data_manager.dart';
import '../../core/routing/app_router.dart';
import '../widgets/section_header.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/version_service.dart';
import '../providers/auth_provider.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account & Settings',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // User Info Card
              Consumer(
                builder: (context, ref, child) {
                  final user = ref.watch(authProvider).value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppTheme.getCardDecoration(borderRadius: 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  gradient: AppTheme.accentGradient,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.accentColor.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    (user?.username ?? 'U').substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user?.username ?? 'Trader',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Google Authenticated',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.accentColor.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRouter.editProfile);
                                },
                                icon: const Icon(
                                  Icons.edit_note_rounded,
                                  color: AppTheme.accentColor,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: AppTheme.borderColor, thickness: 1, height: 1),
                          ),
                          _buildAccountBalanceInfo(context, ref, user?.initialBalance ?? 0.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Data Management
              SectionHeader(title: 'Data Management'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.file_download_outlined,
                  title: 'Export to CSV',
                  subtitle: 'Save your trades as a spreadsheet',
                  onTap: () async {
                    try {
                      await ref.read(dataManagerProvider).exportCsv();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Exported successfully!'),
                            backgroundColor: AppTheme.successColor,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceAll('Exception: ', ''),
                            ),
                            backgroundColor: AppTheme.errorColor,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.file_upload_outlined,
                  title: 'Import from CSV',
                  subtitle: 'Load trades from a spreadsheet',
                  onTap: () async {
                    try {
                      await ref.read(dataManagerProvider).importCsv();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Imported successfully!'),
                            backgroundColor: AppTheme.successColor,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceAll('Exception: ', ''),
                            ),
                            backgroundColor: AppTheme.errorColor,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),


              // Danger Zone
              SectionHeader(title: 'Danger Zone'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.bug_report_outlined,
                  title: 'Generate Dummy Data',
                  subtitle: 'Add 50 random trades for testing',
                  iconColor: AppTheme.warningColor,
                  onTap: () async {
                    try {
                      await ref.read(dataManagerProvider).generateDummyData();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Generated 50 dummy trades!'),
                            backgroundColor: AppTheme.successColor,
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceAll('Exception: ', ''),
                            ),
                            backgroundColor: AppTheme.errorColor,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.delete_outline,
                  title: 'Delete All Trades',
                  subtitle: 'Clear all data from the database',
                  iconColor: AppTheme.errorColor,
                  isDisabled: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppTheme.cardDark,
                        title: const Text(
                          'Delete All Trades?',
                          style: TextStyle(color: AppTheme.textColor),
                        ),
                        content: const Text(
                          'This action cannot be undone. All trades will be permanently deleted.',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: AppTheme.accentColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                await ref.read(dataManagerProvider).clearAllTrades();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('All trades deleted successfully'),
                                      backgroundColor: AppTheme.successColor,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: AppTheme.errorColor,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: AppTheme.errorColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // About Section
              SectionHeader(title: 'About'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: AppTheme.getCardDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SenuaTrade',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<PackageInfo>(
                        future: PackageInfo.fromPlatform(),
                        builder: (context, snapshot) {
                          final version = snapshot.data?.version ?? '1.0.0';
                          final buildNumber = snapshot.data?.buildNumber ?? '1';
                          return Text(
                            'Version $version+$buildNumber',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A comprehensive trading journal application for tracking and analyzing your trades.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: AppTheme.textSecondary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.system_update_alt_outlined,
                  title: 'Check for Updates',
                  subtitle: 'Stay on the latest version',
                  onTap: () {
                    VersionService().checkForUpdate(
                      context,
                      showNoUpdate: true,
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Logout Section
              SectionHeader(title: 'Account Actions'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSettingItem(
                  icon: Icons.logout_rounded,
                  title: 'Sign Out',
                  subtitle: 'Safely log out of your account',
                  iconColor: AppTheme.errorColor,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppTheme.cardDark,
                        title: const Text(
                          'Sign Out?',
                          style: TextStyle(color: AppTheme.textColor),
                        ),
                        content: const Text(
                          'Are you sure you want to sign out?',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: AppTheme.accentColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context); // Close dialog
                              await ref.read(authProvider.notifier).logout();
                              // Navigation happens automatically via main.dart listener
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(color: AppTheme.errorColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountBalanceInfo(BuildContext context, WidgetRef ref, double initialBalance) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Initial Balance',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${initialBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => _showBalanceDialog(context, ref, initialBalance),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentColor.withValues(alpha: 0.1),
            foregroundColor: AppTheme.accentColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            'Set Balance',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showBalanceDialog(BuildContext context, WidgetRef ref, double currentBalance) {
    final controller = TextEditingController(text: currentBalance.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardDark,
        title: const Text('Initial Balance', style: TextStyle(color: AppTheme.textColor)),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: AppTheme.textColor),
          decoration: const InputDecoration(
            labelText: 'Enter starting capital',
            labelStyle: TextStyle(color: AppTheme.textSecondary),
            prefixText: '\$ ',
            prefixStyle: TextStyle(color: AppTheme.accentColor),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.borderColor)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.accentColor)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              final val = double.tryParse(controller.text) ?? 0.0;
              await ref.read(authProvider.notifier).updateInitialBalance(val);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: AppTheme.accentColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDisabled = false,
    Color? iconColor,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: AppTheme.getCardDecoration(),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: (iconColor ?? AppTheme.accentColor).withValues(
                  alpha: 0.15,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                icon,
                color: iconColor ?? AppTheme.accentColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDisabled
                          ? AppTheme.textSecondary
                          : AppTheme.textColor,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDisabled
                  ? AppTheme.textSecondary.withValues(alpha: 0.3)
                  : AppTheme.accentColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
