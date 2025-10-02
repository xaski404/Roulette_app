import 'package:flutter/material.dart';
import 'party_spin_bottle_screen.dart';
import 'party_game_screen.dart';

class PartyModeSelectionScreen extends StatelessWidget {
  const PartyModeSelectionScreen({super.key});

  static const List<_PartyMode> modes = [
    _PartyMode(title: 'Klasyczna Gra', value: 'klasyczna', icon: Icons.celebration),
    _PartyMode(title: 'Dla Par', value: 'dla par', icon: Icons.favorite),
    _PartyMode(title: 'Imprezowy Rozkręcacz', value: 'imprezowa', icon: Icons.local_bar),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Party Modes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: modes.length,
        itemBuilder: (context, index) {
          final mode = modes[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PartyGameScreen(gameCategory: mode.value),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: isDark ? null : Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(mode.icon, size: 48, color: colorScheme.primary),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      mode.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PartyMode {
  final String title;
  final String value;
  final IconData icon;

  const _PartyMode({required this.title, required this.value, required this.icon});
}


