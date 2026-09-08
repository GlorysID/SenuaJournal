import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/trade_entity.dart';
import 'package:intl/intl.dart';

class ContributionHeatmap extends StatefulWidget {
  final List<TradeEntity> trades;
  final int? year;

  const ContributionHeatmap({super.key, required this.trades, this.year});

  @override
  State<ContributionHeatmap> createState() => _ContributionHeatmapState();
}

class _ContributionHeatmapState extends State<ContributionHeatmap> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Scroll to the end (current date) after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    
    // Determine start date and number of weeks based on year selection
    final DateTime startDate;
    final int weeksToShow;
    
    if (widget.year != null) {
      startDate = DateTime(widget.year!, 1, 1);
      weeksToShow = 53;
    } else {
      weeksToShow = 20;
      startDate = now.subtract(Duration(days: (weeksToShow * 7) - now.weekday + 1));
    }

    // Map trades to dates (normalized to local date string)
    final Map<String, int> counts = {};
    for (var trade in widget.trades) {
      final dateKey = DateFormat('yyyy-MM-dd').format(trade.date.toLocal());
      counts[dateKey] = (counts[dateKey] ?? 0) + 1;
    }

    final List<Color> colors = [
      AppTheme.cardDark.withValues(alpha: 0.5), // Empty
      AppTheme.accentColor.withValues(alpha: 0.2), // 1 trade
      AppTheme.accentColor.withValues(alpha: 0.4), // 2 trades
      AppTheme.accentColor.withValues(alpha: 0.7), // 3 trades
      AppTheme.accentColor, // 4+ trades
    ];


    const int daysPerWeek = 7;
    const double cellSize = 16.0;
    const double spacing = 5.0;
    const double columnWidth = cellSize + spacing;

    // Build month labels with precise positioning
    final List<Widget> monthLabelWidgets = [];
    DateTime currentMonthDate = startDate;
    
    while (currentMonthDate.isBefore(now.add(const Duration(days: 30)))) {
      // Calculate how many days from startDate to the beginning of this month
      final daysDiff = currentMonthDate.difference(startDate).inDays;
      // Calculate week offset
      final weekOffset = daysDiff / daysPerWeek;
      
      monthLabelWidgets.add(
        Positioned(
          left: weekOffset * columnWidth,
          child: Text(
            DateFormat('MMM').format(currentMonthDate),
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
      );
      
      // Move to next month
      currentMonthDate = DateTime(currentMonthDate.year, currentMonthDate.month + 1, 1);
    }

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Precise Month Labels
          SizedBox(
            height: 20,
            width: weeksToShow * columnWidth,
            child: Stack(
              children: monthLabelWidgets,
            ),
          ),
          const SizedBox(height: 4),
          // Grid
          SizedBox(
            height: (cellSize * daysPerWeek) + (spacing * (daysPerWeek - 1)),
            width: weeksToShow * columnWidth,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: daysPerWeek,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
              ),
              itemCount: weeksToShow * daysPerWeek,
              itemBuilder: (context, index) {
                // Calculate date for this cell
                // In horizontal grid with 7 rows, column 0 is index 0-6
                final date = startDate.add(Duration(days: index));
                final dateKey = DateFormat('yyyy-MM-dd').format(date.toLocal());
                final count = counts[dateKey] ?? 0;
                final bool isToday = dateKey == DateFormat('yyyy-MM-dd').format(now);

                Color color;
                if (count == 0) {
                  color = colors[0];
                } else if (count <= 1) {
                  color = colors[1];
                } else if (count <= 3) {
                  color = colors[2];
                } else if (count <= 5) {
                  color = colors[3];
                } else {
                  color = colors[4];
                }

                // If year is selected, only show days within that year
                if (widget.year != null && date.year != widget.year) {
                  return Container();
                }
                
                // If no year selected (Home screen), hide future days
                if (widget.year == null && date.isAfter(now)) {
                  return Container();
                }

                return Tooltip(
                  message: '${DateFormat.yMMMd().format(date)}: $count trades',
                  child: Container(
                    width: cellSize,
                    height: cellSize,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                      border: isToday 
                        ? Border.all(color: Colors.white, width: 1.5)
                        : (count > 0 
                          ? Border.all(color: AppTheme.accentColor.withValues(alpha: 0.3), width: 0.5)
                          : null),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
