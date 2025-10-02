import 'dart:math';
import 'package:flutter/material.dart';

class RouletteSegment {
  final String label;
  final Color color;
  const RouletteSegment({required this.label, required this.color});
}

class RouletteController {
  Future<void> Function(int index)? _spin;
  Future<void> spinTo(int index) async {
    if (_spin != null) {
      return _spin!(index);
    }
    return Future.value();
  }
}

class RouletteWheel extends StatefulWidget {
  final List<RouletteSegment> segments;
  final RouletteController? controller;
  final Duration wheelDuration;
  final Duration ballDuration;
  final Curve wheelCurve;
  final Curve ballCurve;
  final void Function(int winningIndex)? onCompleted;
  final double size;

  const RouletteWheel({
    super.key,
    required this.segments,
    this.controller,
    this.size = 280,
    this.wheelDuration = const Duration(milliseconds: 4000),
    this.ballDuration = const Duration(milliseconds: 2600),
    this.wheelCurve = Curves.easeOutCubic,
    this.ballCurve = Curves.easeOut,
    this.onCompleted,
  });

  @override
  State<RouletteWheel> createState() => _RouletteWheelState();
}

class _RouletteWheelState extends State<RouletteWheel> with TickerProviderStateMixin {
  late final AnimationController _wheelCtrl;
  late final AnimationController _ballCtrl;
  late Animation<double> _wheelAngle;
  late Animation<double> _ballAngle;
  int? _winningIndex;

  @override
  void initState() {
    super.initState();
    _wheelCtrl = AnimationController(vsync: this, duration: widget.wheelDuration);
    _ballCtrl = AnimationController(vsync: this, duration: widget.ballDuration);
    _wheelAngle = AlwaysStoppedAnimation<double>(0);
    _ballAngle = AlwaysStoppedAnimation<double>(0);

    widget.controller?._spin = _spinToIndex;
  }

  @override
  void dispose() {
    _wheelCtrl.dispose();
    _ballCtrl.dispose();
    super.dispose();
  }

  Future<void> _spinToIndex(int index) async {
    if (_wheelCtrl.isAnimating || _ballCtrl.isAnimating || widget.segments.isEmpty) return;
    final int n = widget.segments.length;
    final double sweep = 2 * pi / n;
    _winningIndex = index % n;

    // Choose large spins for wheel and opposite direction for ball
    final double wheelSpins = 6 * 2 * pi; // multiple full spins
    final double targetWheelAngle = wheelSpins + (_winningIndex! * sweep + sweep / 2);

    final double ballSpins = 8 * 2 * pi; // more spins, opposite direction
    final double targetBallAngle = -ballSpins; // ends at 0; will stick later

    _wheelAngle = Tween<double>(begin: 0, end: targetWheelAngle).animate(CurvedAnimation(parent: _wheelCtrl, curve: widget.wheelCurve));
    _ballAngle = Tween<double>(begin: 0, end: targetBallAngle).animate(CurvedAnimation(parent: _ballCtrl, curve: widget.ballCurve));

    // When ball finishes, "stick" to wheel by syncing listeners
    _ballCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // ball stops orbiting; now ride with wheel using wheelAngle
        setState(() {});
      }
    });

    await Future.wait([
      _ballCtrl.forward(from: 0),
      _wheelCtrl.forward(from: 0),
    ]);

    if (widget.onCompleted != null && _winningIndex != null) {
      widget.onCompleted!(_winningIndex!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_wheelCtrl, _ballCtrl]),
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _wheelAngle.value,
                child: CustomPaint(
                  size: Size.square(size),
                  painter: _RoulettePainter(segments: widget.segments, textColor: colorScheme.onSurface),
                ),
              ),
              // Ball: phase 1 orbit (when _ballCtrl not completed): opposite direction
              if (_ballCtrl.status != AnimationStatus.completed)
                _buildBall(size: size, radiusFactor: 0.45, angle: _ballAngle.value)
              else
                // Phase 2: "stuck" ball riding with wheel near outer track at the winning slice center
                _buildBall(size: size, radiusFactor: 0.40, angle: 0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBall({required double size, required double radiusFactor, required double angle}) {
    final double r = size * radiusFactor;
    final Offset center = Offset(size / 2, size / 2);
    final double x = center.dx + r * cos(angle);
    final double y = center.dy + r * sin(angle);
    return Positioned(
      left: x - 8,
      top: y - 8,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 6, offset: const Offset(0, 2))],
          border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
        ),
      ),
    );
  }
}

class _RoulettePainter extends CustomPainter {
  final List<RouletteSegment> segments;
  final Color textColor;
  _RoulettePainter({required this.segments, required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer ring
    final ring = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.04;
    canvas.drawCircle(center, radius - ring.strokeWidth / 2, ring);

    // Background
    final bg = Paint()
      ..color = Colors.black.withOpacity(0.04)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - ring.strokeWidth, bg);

    if (segments.isEmpty) return;

    final int n = segments.length;
    final double sweep = 2 * pi / n;
    final Rect rect = Rect.fromCircle(center: center, radius: radius - ring.strokeWidth);

    for (int i = 0; i < n; i++) {
      final start = i * sweep;
      final segPaint = Paint()..color = segments[i].color;
      canvas.drawArc(rect, start, sweep, true, segPaint);

      // separator
      final sep = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      final p = Offset(center.dx + (radius - ring.strokeWidth) * cos(start), center.dy + (radius - ring.strokeWidth) * sin(start));
      canvas.drawLine(center, p, sep);

      // label
      final middle = start + sweep / 2;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(middle);
      final ts = TextSpan(text: segments[i].label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14));
      final tp = TextPainter(text: ts, textDirection: TextDirection.ltr, maxLines: 1, ellipsis: '…')..layout(maxWidth: radius * 0.9);
      tp.paint(canvas, Offset((radius - ring.strokeWidth) * 0.65 - tp.width / 2, -tp.height / 2));
      canvas.restore();
    }

    // Outer studs
    final studs = 28;
    final studsR = (radius - ring.strokeWidth / 2) - (ring.strokeWidth * 0.25);
    final studPaint = Paint()..color = Colors.white;
    for (int i = 0; i < studs; i++) {
      final a = (2 * pi * i) / studs;
      final o = Offset(center.dx + studsR * cos(a), center.dy + studsR * sin(a));
      canvas.drawCircle(o, radius * 0.015, studPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RoulettePainter oldDelegate) {
    return oldDelegate.segments != segments || oldDelegate.textColor != textColor;
  }
}


