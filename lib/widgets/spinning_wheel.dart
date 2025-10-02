import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Shared color palette for wheel segments
const List<Color> _wheelColors = [
  Color(0xFF00E5FF), // Cyan A400
  Color(0xFFFF4081), // Pink A200
  Color(0xFFFFC400), // Amber A700
  Color(0xFF69F0AE), // Green A200
  Color(0xFF7C4DFF), // Deep Purple A200
  Color(0xFFFF6E40), // Deep Orange A200
];

/// A reusable, interactive spinning wheel widget that renders a wheel of
/// segments based on the provided [players] list and spins to select a winner.
class SpinningWheel extends StatefulWidget {
  final List<String> players;
  final double size;
  final Duration duration;
  final bool showCenterButton;
  final bool showWinnerLabel;
  final void Function(String name, int index)? onWinner;

  const SpinningWheel({
    super.key,
    required this.players,
    this.size = 280,
    this.duration = const Duration(seconds: 4),
    this.showCenterButton = false,
    this.showWinnerLabel = false,
    this.onWinner,
  });

  @override
  State<SpinningWheel> createState() => SpinningWheelState();
}

class SpinningWheelState extends State<SpinningWheel>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _rotation;

  // Tracks the absolute rotation angle accumulated across spins
  double _currentRotation = 0.0;
  String? _winner;
  int? _winnerIndex;
  Completer<String>? _spinCompleter;
  VoidCallback? _tickListener;
  int? _lastTickBucket;
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  static const int _kFullRotations = 5; // visual flair

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _rotation = AlwaysStoppedAnimation<double>(_currentRotation);
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _pulse = CurvedAnimation(parent: _pulseController, curve: Curves.easeOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Persist the final rotation value for subsequent spins
        _currentRotation = _rotation.value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<String> spin() {
    if (widget.players.isEmpty) {
      return Future.error(StateError('No players to spin'));
    }
    if (_controller.isAnimating) {
      return Future.error(StateError('Already spinning'));
    }

    final int n = widget.players.length;
    final double segmentAngle = 2 * pi / n;

    // Randomly pick a winner and a small offset within the segment to avoid
    // stopping exactly at the same visual angle every time.
    final rng = Random();
    final int winningIndex = rng.nextInt(n);
    final double jitter = (rng.nextDouble() - 0.5) * (segmentAngle * 0.5);

    // Center angle of the chosen segment.
    final double centerAngle = winningIndex * segmentAngle + segmentAngle / 2;

    // We want the center of the winning segment to land under the fixed pointer
    // at the top (12 o'clock). Pointer direction angle is -pi/2.
    final double pointerAngle = -pi / 2;

    // Desired absolute end rotation such that (centerAngle + endRotation) == pointerAngle (mod 2pi).
    // Solve for endRotation: endRotation = pointerAngle - (centerAngle + jitter) + k * 2pi.
    final double desiredTurnWithinCycle = _normalizeAngle(pointerAngle - (centerAngle + jitter) - _currentRotation);
    final double target = _currentRotation + (_kFullRotations * 2 * pi) + desiredTurnWithinCycle;

    final begin = _currentRotation;
    final end = target;

    _rotation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // remove ticking listener
          if (_tickListener != null) {
            _controller.removeListener(_tickListener!);
            _tickListener = null;
          }
          _currentRotation = end;
          _winnerIndex = winningIndex;
          _winner = widget.players[winningIndex];
          if (widget.onWinner != null) {
            widget.onWinner!(_winner!, _winnerIndex!);
          }
          if (_spinCompleter != null && !_spinCompleter!.isCompleted) {
            _spinCompleter!.complete(_winner!);
          }
          _pulseController
            ..reset()
            ..forward();
          if (mounted) setState(() {});
        }
      });

    // set up ticking feedback on segment boundary crossings
    _lastTickBucket = ((begin % (2 * pi)) / segmentAngle).floor();
    _tickListener = () {
      final ang = _rotation.value;
      final bucket = ((ang % (2 * pi)) / segmentAngle).floor();
      if (bucket != _lastTickBucket) {
        _lastTickBucket = bucket;
        SystemSound.play(SystemSoundType.click);
      }
    };
    _controller.addListener(_tickListener!);

    _controller
      ..reset()
      ..forward();

    _spinCompleter = Completer<String>();
    return _spinCompleter!.future;
  }

  double _normalizeAngle(double angle) {
    // Normalize to [0, 2pi)
    double a = angle % (2 * pi);
    if (a < 0) a += 2 * pi;
    return a;
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: size,
      height: size + 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shadow under wheel for depth
          Positioned(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 24,
                    spreadRadius: -4,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
            ),
          ),

          // Bottom layer: the wheel (rotating)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotation.value,
                child: child,
              );
            },
            child: CustomPaint(
              size: Size.square(size),
              painter: WheelPainter(
                players: widget.players,
                backgroundColor: colorScheme.surface,
                textColor: colorScheme.onSurface,
              ),
            ),
          ),

          // Winner pulse overlay (highlights the top segment after spin)
          if (_winnerIndex != null)
            AnimatedBuilder(
              animation: _pulse,
              builder: (context, _) {
                final sweep = widget.players.isEmpty ? 0.0 : 2 * pi / widget.players.length;
                final color = _wheelColors[_winnerIndex!.clamp(0, _wheelColors.length - 1) % _wheelColors.length];
                return IgnorePointer(
                  child: CustomPaint(
                    size: Size.square(size),
                    painter: WinnerPulsePainter(
                      progress: _pulse.value,
                      sweep: sweep,
                      color: color,
                    ),
                  ),
                );
              },
            ),

          // Center hub overlay with refresh icon (acts as spinner trigger)
          Positioned(
            child: GestureDetector(
              onTap: () {
                if (!_controller.isAnimating && widget.players.isNotEmpty) {
                  spin();
                }
              },
              child: Container(
                width: size * 0.16,
                height: size * 0.16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.black.withOpacity(0.15), width: 2),
                ),
                child: Icon(
                  Icons.autorenew,
                  color: _controller.isAnimating ? Colors.black38 : Colors.black87,
                  size: size * 0.08,
                ),
              ),
            ),
          ),

          // Top layer: spin button in center
          if (widget.showCenterButton)
            Positioned(
              child: ElevatedButton(
                onPressed: _controller.isAnimating || widget.players.isEmpty
                    ? null
                    : () {
                        spin();
                      },
                child: Text(_controller.isAnimating ? 'Spinning...' : 'SPIN'),
              ),
            ),

          if (widget.showWinnerLabel)
            Positioned(
              bottom: 0,
              child: _winner == null
                  ? Text(
                      'Tap SPIN to choose',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Winner',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.85, end: 1.0),
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOut,
                            builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                            child: Text(
                              _winner!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _wheelColors[_winnerIndex!.clamp(0, _wheelColors.length - 1) % _wheelColors.length],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}

/// Draws a triangle that points downward (used as the fixed pointer at top).
class _PointerTriangle extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  const _PointerTriangle({required this.color, this.width = 22, this.height = 14});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: _TrianglePainter(color: color),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter responsible for drawing the wheel segments and player names.
class WheelPainter extends CustomPainter {
  final List<String> players;
  final Color backgroundColor;
  final Color textColor;

  WheelPainter({
    required this.players,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer ring (white border) for premium look
    final outerRing = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.04; // proportional ring
    canvas.drawCircle(center, radius - outerRing.strokeWidth / 2, outerRing);

    // Background circle underneath segments
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - outerRing.strokeWidth, bgPaint);

    // Studs (small dots) around the outer ring for premium look
    final int studs = 28;
    final double studsRadius = (radius - outerRing.strokeWidth / 2) - (outerRing.strokeWidth * 0.25);
    final double studSize = radius * 0.015;
    final studFill = Paint()..color = Colors.white.withOpacity(0.9);
    final studBorder = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (int i = 0; i < studs; i++) {
      final double a = (2 * pi * i) / studs;
      final Offset p = Offset(center.dx + studsRadius * cos(a), center.dy + studsRadius * sin(a));
      canvas.drawCircle(p, studSize, studFill);
      canvas.drawCircle(p, studSize, studBorder);
    }

    if (players.isEmpty) return;

    final int n = players.length;
    final double sweep = 2 * pi / n;

    // Draw each segment as a filled arc and render the player's name.
    for (int i = 0; i < n; i++) {
      final startAngle = i * sweep;

      // Segment with subtle sweep gradient for depth
      final baseColor = _wheelColors[i % _wheelColors.length];
      final paint = Paint()..style = PaintingStyle.fill;
      paint.shader = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweep,
        tileMode: TileMode.clamp,
        colors: [
          baseColor.withOpacity(0.95),
          baseColor.withOpacity(0.75),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      final rect = Rect.fromCircle(center: center, radius: radius - outerRing.strokeWidth);
      canvas.drawArc(rect, startAngle, sweep, true, paint);

      // Segment separator
      final separatorPaint = Paint()
        ..color = Colors.white.withOpacity(0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      final start = Offset(
        center.dx + (radius - outerRing.strokeWidth) * cos(startAngle),
        center.dy + (radius - outerRing.strokeWidth) * sin(startAngle),
      );
      canvas.drawLine(center, start, separatorPaint);

      // Label: transform-based placement
      final middleAngle = startAngle + sweep / 2;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(middleAngle);

      final label = players[i];
      final textSpan = TextSpan(
        text: label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      );
      final tp = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: radius * 0.9);

      final textOffset = Offset((radius - outerRing.strokeWidth) * 0.65 - tp.width / 2, -tp.height / 2);
      tp.paint(canvas, textOffset);
      canvas.restore();
    }

    // Hub
    final hubPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.1, hubPaint);

    final hubRing = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.1, hubRing);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.players != players ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.textColor != textColor;
  }
}

// Paints a pulsating wedge centered at the top pointer to celebrate winner
class WinnerPulsePainter extends CustomPainter {
  final double progress; // 0..1
  final double sweep; // segment sweep angle
  final Color color;

  WinnerPulsePainter({required this.progress, required this.sweep, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (sweep == 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final startAngle = -pi / 2 - sweep / 2; // center the pulse at the top pointer
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity((0.25 * progress).clamp(0.0, 0.25));
    final rect = Rect.fromCircle(center: center, radius: radius * (0.9 + 0.1 * progress));
    canvas.drawArc(rect, startAngle, sweep, true, paint);
  }

  @override
  bool shouldRepaint(covariant WinnerPulsePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color || oldDelegate.sweep != sweep;
  }
}


