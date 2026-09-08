import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ConnectedDiamonds extends StatelessWidget {
  final String val1;
  final String label1;
  final String val2;
  final String label2;
  final String val3;
  final String label3;

  const ConnectedDiamonds({
    super.key,
    required this.val1,
    required this.label1,
    required this.val2,
    required this.label2,
    required this.val3,
    required this.label3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _DiamondsPainter(color: AppTheme.accentColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDiamondContent(val1, label1),
              _buildDiamondContent(val2, label2),
              _buildDiamondContent(val3, label3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiamondContent(String val, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          val,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.black87),
        ),
      ],
    );
  }
}

class _DiamondsPainter extends CustomPainter {
  final Color color;

  _DiamondsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();

    // Draw 3 connected diamond/hexagon-like shapes
    final w = size.width;
    final h = size.height;
    final diamondWidth = w / 3;
    final vOffset = h * 0.2;

    // A simplified wavy interlocking shape that resembles the diamonds
    path.moveTo(0, h / 2);

    // Diamond 1 top peak
    path.lineTo(diamondWidth * 0.5, vOffset);
    // Valley 1
    path.lineTo(diamondWidth, h / 2 - vOffset / 2);
    // Diamond 2 top peak
    path.lineTo(diamondWidth * 1.5, vOffset);
    // Valley 2
    path.lineTo(diamondWidth * 2, h / 2 - vOffset / 2);
    // Diamond 3 top peak
    path.lineTo(diamondWidth * 2.5, vOffset);

    // Right Edge
    path.lineTo(w, h / 2);

    // Diamond 3 bottom peak
    path.lineTo(diamondWidth * 2.5, h - vOffset);
    // Valley Bottom 2
    path.lineTo(diamondWidth * 2, h / 2 + vOffset / 2);
    // Diamond 2 bottom peak
    path.lineTo(diamondWidth * 1.5, h - vOffset);
    // Valley Bottom 1
    path.lineTo(diamondWidth, h / 2 + vOffset / 2);
    // Diamond 1 bottom peak
    path.lineTo(diamondWidth * 0.5, h - vOffset);

    path.close();

    // The image has smooth rounded edges on these diamonds,
    // replacing explicit lines with some bézier curves would be better but this is a solid geometric proxy.
    // Let's add slight rounding by using a thicker stroke with round joins if needed,
    // or keep the angular modern look for now.

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
