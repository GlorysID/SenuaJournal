import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_overview_view.dart';
import 'trades_list_view.dart';
import 'dashboard_view.dart';
import 'settings_view.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppTheme.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const HomeOverviewView(),
            TradesListView(),
            const DashboardView(),
            const SettingsView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            border: Border(
              top: BorderSide(
                color: AppTheme.borderColor.withValues(alpha: 0.3),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    0,
                    Icons.home_filled,
                    'Home',
                    Icons.home_outlined,
                  ),
                  _buildNavItem(
                    1,
                    Icons.trending_up_rounded,
                    'Trades',
                    Icons.trending_up_outlined,
                  ),
                  _buildNavItem(
                    2,
                    Icons.bar_chart_rounded,
                    'Analytics',
                    Icons.bar_chart_outlined,
                  ),
                  _buildNavItem(
                    3,
                    Icons.person_rounded,
                    'Profile',
                    Icons.person_outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    String label,
    IconData inactiveIcon,
  ) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 8,
          vertical: 8,
        ),
        decoration: isSelected
            ? BoxDecoration(
                gradient: AppTheme.accentGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? Colors.black : AppTheme.textSecondary,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ] else ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
