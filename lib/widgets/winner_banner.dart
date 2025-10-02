import 'package:flutter/material.dart';

class WinnerBanner extends StatelessWidget {
  final String? winnerName;

  const WinnerBanner({super.key, required this.winnerName});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final background = isDark
        ? colorScheme.surface.withOpacity(0.6)
        : colorScheme.surface.withOpacity(0.85);

    final placeholder = Text(
      'Zakręć kołem, aby wylosować',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.9),
        fontWeight: FontWeight.bold,
      ),
    );

    Widget resultContent(String name) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ZWYCIĘZCA',
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.primary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.black12,
          width: 1,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: winnerName == null
            ? const KeyedSubtree(key: ValueKey('placeholder'), child: _StaticPlaceholder())
            : KeyedSubtree(
                key: ValueKey('winner_${DateTime.now().millisecondsSinceEpoch}'),
                child: _SlideFade(child: resultContent(winnerName!)),
              ),
      ),
    );
  }
}

class _StaticPlaceholder extends StatelessWidget {
  const _StaticPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      'Zakręć kołem, aby wylosować',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.9),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SlideFade extends StatelessWidget {
  final Widget child;
  const _SlideFade({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 8),
            child: child,
          ),
        );
      },
    );
  }
}


