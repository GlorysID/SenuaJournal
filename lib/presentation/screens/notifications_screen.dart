import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Welcome to Trading Journal Pro!',
        'body':
            'Start tracking your trades and improve your performance today.',
        'time': 'Just now',
        'icon': '👋',
      },
      {
        'title': 'New Feature: CSV Export',
        'body':
            'You can now export your trading history to a CSV file from Settings.',
        'time': '2 hours ago',
        'icon': '📊',
      },
      {
        'title': 'Security Alert',
        'body':
            'Remember to back up your database regularly to avoid data loss.',
        'time': 'Yesterday',
        'icon': '🛡️',
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.borderColor.withValues(alpha: 0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    item['icon']!,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title']!,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textColor,
                                fontSize: 15,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                          Text(
                            item['time']!,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['body']!,
                        style: TextStyle(
                          color: AppTheme.textSecondary.withValues(alpha: 0.9),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
