import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/trade_entity.dart';
import '../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'add_trade_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/trade_provider.dart';

class TradeDetailScreen extends ConsumerWidget {
  final TradeEntity trade;

  const TradeDetailScreen({super.key, required this.trade});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProfit = (trade.pnl ?? 0) >= 0;
    final pnlColor = trade.pnl == null
        ? Colors.grey
        : (isProfit ? AppTheme.successColor : AppTheme.errorColor);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        title: Text(
          'Trade Details',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: AppTheme.accentColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTradeScreen(trade: trade),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.errorColor),
            onPressed: () => _showDeleteDialog(context, ref),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                decoration: AppTheme.getCardDecoration(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trade.pair,
                              style: GoogleFonts.outfit(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${trade.direction} • ${trade.marketType}',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    trade.direction.toLowerCase() == 'long' ||
                                        trade.direction.toLowerCase() == 'buy'
                                    ? AppTheme.successColor
                                    : AppTheme.errorColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              trade.pnl != null
                                  ? '\$${trade.pnl!.toStringAsFixed(2)}'
                                  : 'Open',
                              style: GoogleFonts.outfit(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: pnlColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat.yMMMd().add_jm().format(trade.date),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Entry/Exit Info
              const Text(
                'Execution Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: AppTheme.getCardDecoration(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Entry Price',
                      '\$${trade.entryPrice.toStringAsFixed(4)}',
                    ),
                    if (trade.exitPrice != null)
                      _buildDetailRow(
                        'Exit Price',
                        '\$${trade.exitPrice!.toStringAsFixed(4)}',
                      ),
                    if (trade.stopLoss != null)
                      _buildDetailRow(
                        'Stop Loss',
                        '\$${trade.stopLoss!.toStringAsFixed(4)}',
                      ),
                    if (trade.takeProfit != null)
                      _buildDetailRow(
                        'Take Profit',
                        '\$${trade.takeProfit!.toStringAsFixed(4)}',
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Risk & Sizing
              const Text(
                'Position & Risk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: AppTheme.getCardDecoration(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Position Size',
                      '\$${trade.positionSize.toStringAsFixed(2)}',
                    ),
                    if (trade.leverage != null)
                      _buildDetailRow('Leverage', '${trade.leverage}x'),
                    if (trade.riskRewardRatio != null &&
                        trade.riskRewardRatio!.isNotEmpty)
                      _buildDetailRow('Risk:Reward', trade.riskRewardRatio!),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Psychology & Rationality
              if ((trade.emotion != null && trade.emotion!.isNotEmpty) ||
                  (trade.reason != null && trade.reason!.isNotEmpty)) ...[
                const Text(
                  'Psychology & Rationality',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: AppTheme.getCardDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (trade.emotion != null && trade.emotion!.isNotEmpty)
                        _buildDetailRow('Emosi', trade.emotion!),
                      if (trade.reason != null && trade.reason!.isNotEmpty)
                        _buildDetailRow('Alasan', trade.reason!),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Notes section
              if (trade.notes != null && trade.notes!.isNotEmpty) ...[
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: AppTheme.getCardDecoration(),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    trade.notes!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Screenshot
              if (trade.screenshotPath != null &&
                  trade.screenshotPath!.isNotEmpty) ...[
                const Text(
                  'Screenshot',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(trade.screenshotPath!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      padding: const EdgeInsets.all(20),
                      color: AppTheme.cardDark,
                      child: const Center(
                        child: Text(
                          'Image not found or unavailable',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardDark,
        title: const Text('Delete Trade?', style: TextStyle(color: AppTheme.textColor)),
        content: const Text(
          'Are you sure you want to delete this trade? This action cannot be undone.',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.accentColor)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await ref.read(tradesProvider.notifier).deleteTrade(trade.id);
              if (context.mounted) Navigator.pop(context); // Go back to list
            },
            child: const Text('Delete', style: TextStyle(color: AppTheme.errorColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
