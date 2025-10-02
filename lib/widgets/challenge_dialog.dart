import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

Future<void> showChallengeDialog({
  required BuildContext context,
  required String winnerName,
  required String challengeText,
  Color? accentColor,
  IconData? icon,
}) async {
  final ColorScheme cs = Theme.of(context).colorScheme;
  final Color borderColor = accentColor ?? cs.primary;
  final IconData usedIcon = icon ?? Icons.flash_on_rounded;

  late final ConfettiController _confetti;

  await showGeneralDialog(
    context: context,
    barrierLabel: 'challenge',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, _, __) {
      _confetti = ConfettiController(duration: const Duration(milliseconds: 1200));
      // Fire on first frame
      WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());

      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cs.surface.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: borderColor.withOpacity(0.6), width: 1),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 18, offset: const Offset(0, 8)),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Wyzwanie dla:',
                          style: TextStyle(color: cs.onSurface.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          winnerName,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: borderColor, fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: borderColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(usedIcon, color: borderColor, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                challengeText,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: cs.onSurface, fontSize: 18, fontWeight: FontWeight.w600, height: 1.35),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cs.primary,
                              foregroundColor: cs.onPrimary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 3,
                            ),
                            onPressed: () => Navigator.of(context).maybePop(),
                            child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -8,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 20,
                  minBlastForce: 5,
                  numberOfParticles: 18,
                  emissionFrequency: 0.01,
                  gravity: 0.9,
                  colors: const [Colors.amber, Colors.pinkAccent, Colors.cyanAccent, Colors.limeAccent],
                ),
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, anim, _, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOut, reverseCurve: Curves.easeIn);
      return Opacity(
        opacity: curved.value,
        child: Transform.scale(
          scale: 0.95 + 0.05 * curved.value,
          child: child,
        ),
      );
    },
  );
}


