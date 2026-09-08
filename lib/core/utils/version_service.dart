import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class VersionService {
  static const String _versionUrl =
      'https://raw.githubusercontent.com/GlorysID/SenuaJournal/main/version.json';

  Future<void> checkForUpdate(
    BuildContext context, {
    bool showNoUpdate = false,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_versionUrl?t=${DateTime.now().millisecondsSinceEpoch}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String latestVersion = data['version'];
        final int latestBuildNumber = int.parse(data['buildNumber']);
        final String downloadUrl = data['downloadUrl'];
        final String releaseNotes =
            data['releaseNotes'] ?? 'No release notes provided.';

        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final String currentVersion = packageInfo.version;
        final int currentBuildNumber = int.parse(packageInfo.buildNumber);

        debugPrint(
          'Update Check: Local($currentVersion+$currentBuildNumber) vs Remote($latestVersion+$latestBuildNumber)',
        );

        if (_isNewerVersion(
          latestVersion,
          latestBuildNumber,
          currentVersion,
          currentBuildNumber,
        )) {
          if (context.mounted) {
            _showUpdateDialog(
              context,
              latestVersion,
              downloadUrl,
              releaseNotes,
            );
          }
        } else {
          if (showNoUpdate && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'App is up to date (v$currentVersion+$currentBuildNumber)',
                ),
                backgroundColor: AppTheme.successColor,
              ),
            );
          }
        }
      } else {
        if (showNoUpdate && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to connect to update server.'),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error checking for update: $e');
      if (showNoUpdate && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update Error: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  bool _isNewerVersion(
    String latestVer,
    int latestBuild,
    String currentVer,
    int currentBuild,
  ) {
    if (latestBuild > currentBuild) return true;

    List<int> latestParts = latestVer.split('.').map(int.parse).toList();
    List<int> currentParts = currentVer.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length && i < currentParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }

    return latestParts.length > currentParts.length;
  }

  void _showUpdateDialog(
    BuildContext context,
    String version,
    String url,
    String notes,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Update Available!',
          style: TextStyle(
            color: AppTheme.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A new version ($version) is available.',
              style: const TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Release Notes:',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              notes,
              style: const TextStyle(color: AppTheme.textColor, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Later',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              final Uri uri = Uri.parse(url);
              try {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  // Fallback: try launching directly if canLaunchUrl fails (common on some Android versions)
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open browser: $e')),
                  );
                }
              }
            },
            child: const Text(
              'Download',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
