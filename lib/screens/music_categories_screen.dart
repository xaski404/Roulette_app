import 'package:flutter/material.dart';
import '../services/music_service.dart';
import 'music_category_detail_screen.dart';

class MusicCategoriesScreen extends StatefulWidget {
  const MusicCategoriesScreen({super.key});

  @override
  State<MusicCategoriesScreen> createState() => _MusicCategoriesScreenState();
}

class _MusicCategoriesScreenState extends State<MusicCategoriesScreen> {
  final MusicService _musicService = MusicService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMusicOptions();
  }

  Future<void> _initializeMusicOptions() async {
    if (!_isInitialized) {
      await _musicService.initializeDefaultMusicOptions();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  // Get icon for each category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Song':
        return Icons.music_note;
      case 'Album':
        return Icons.album;
      case 'Playlist':
        return Icons.playlist_play;
      case 'Music genre':
        return Icons.queue_music;
      default:
        return Icons.music_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Music Categories'),
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
        itemCount: MusicService.categories.length,
        itemBuilder: (context, index) {
          final category = MusicService.categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicCategoryDetailScreen(
                    category: category,
                  ),
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
                  Icon(
                    _getCategoryIcon(category),
                    size: 48,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      category,
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