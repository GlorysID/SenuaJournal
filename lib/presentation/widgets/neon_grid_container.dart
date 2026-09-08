import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class NeonGridDashboard extends StatelessWidget {
  final String tlTitle;
  final String tlValue;
  final String trTitle;
  final String trValue;
  final String blTitle;
  final String blValue;
  final String brTitle;
  final String brValue;

  const NeonGridDashboard({
    super.key,
    required this.tlTitle,
    required this.tlValue,
    required this.trTitle,
    required this.trValue,
    required this.blTitle,
    required this.blValue,
    required this.brTitle,
    required this.brValue,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // 1:1 square grid roughly
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final gap = 16.0;
          final cornerRadius = 32.0;

          final cellWidth = (width - gap) / 2;
          final cellHeight = (height - gap) / 2;

          return Stack(
            children: [
              // 1. The unified green shape (Top-Right and Bottom-Left connected)
              // We'll simulate the blob by drawing a single CustomPainter
              Positioned.fill(
                child: CustomPaint(
                  painter: _NeonBlobPainter(
                    color: AppTheme.accentColor,
                    gap: gap,
                    radius: cornerRadius,
                  ),
                ),
              ),

              // 2. Top-Left Dark Card
              Positioned(
                top: 0,
                left: 0,
                width: cellWidth,
                height: cellHeight,
                child: _buildDarkCard(tlTitle, tlValue, Icons.percent),
              ),

              // 3. Bottom-Right Dark Card
              Positioned(
                bottom: 0,
                right: 0,
                width: cellWidth,
                height: cellHeight,
                child: _buildDarkCard(
                  brTitle,
                  brValue,
                  Icons.pie_chart_outline,
                ),
              ),

              // 4. Top-Right Text Content (on top of green)
              Positioned(
                top: 0,
                right: 0,
                width: cellWidth,
                height: cellHeight,
                child: _buildGreenContent(
                  trTitle,
                  trValue,
                  Icons.group_outlined,
                ),
              ),

              // 5. Bottom-Left Text Content (on top of green)
              Positioned(
                bottom: 0,
                left: 0,
                width: cellWidth,
                height: cellHeight,
                child: _buildGreenContent(
                  blTitle,
                  blValue,
                  Icons.shopping_bag_outlined,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDarkCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildGreenContent(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeonBlobPainter extends CustomPainter {
  final Color color;
  final double gap;
  final double radius;

  _NeonBlobPainter({
    required this.color,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final halfW = size.width / 2;
    final halfH = size.height / 2;
    final gapHalf = gap / 2;

    // We draw a shape that covers TR and BL, and swoops through the center connecting them.
    // Start at top-middle, right of gap
    path.moveTo(halfW + gapHalf, radius);

    // Top Right Corner
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
    );

    // Bottom Right of the Top-Right cell
    path.lineTo(size.width, halfH - gapHalf - radius);
    path.arcToPoint(
      Offset(size.width - radius, halfH - gapHalf),
      radius: Radius.circular(radius),
    );

    // Smooth transition through center to Bottom-Left cell
    // Draw line to the center intersection point (approx)
    path.lineTo(halfW + gapHalf + radius, halfH - gapHalf);
    // Inner curve connecting TR and BL
    path.quadraticBezierTo(
      halfW - gapHalf,
      halfH - gapHalf, // control point (middle)
      halfW - gapHalf,
      halfH + gapHalf + radius, // end point
    );

    // Bottom Right of Bottom-Left cell
    path.lineTo(halfW - gapHalf, size.height - radius);
    path.arcToPoint(
      Offset(halfW - gapHalf - radius, size.height),
      radius: Radius.circular(radius),
    );

    // Bottom Left Corner
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
    );

    // Top Left of Bottom-Left cell
    path.lineTo(0, halfH + gapHalf + radius);
    path.arcToPoint(
      Offset(radius, halfH + gapHalf),
      radius: Radius.circular(radius),
    );

    // Smooth transition back up to Top-Right cell
    path.lineTo(halfW - gapHalf - radius, halfH + gapHalf);
    // Inner curve connecting BL and TR
    path.quadraticBezierTo(
      halfW + gapHalf,
      halfH + gapHalf, // control point (middle)
      halfW + gapHalf,
      halfH - gapHalf - radius, // end point
    );

    // Top Left of Top-Right cell
    path.lineTo(halfW + gapHalf, radius);
    path.arcToPoint(
      Offset(halfW + gapHalf + radius, 0),
      radius: Radius.circular(radius),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
