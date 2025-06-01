import 'package:flutter/material.dart';
import '../services/spotify_service.dart';

class ShuffleSongWidget extends StatefulWidget {
  const ShuffleSongWidget({Key? key}) : super(key: key);

  @override
  State<ShuffleSongWidget> createState() => _ShuffleSongWidgetState();
}

class _ShuffleSongWidgetState extends State<ShuffleSongWidget> {
  final SpotifyService _spotifyService = SpotifyService();
  Map<String, dynamic>? _currentTrack;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // _getRandomTrack(); // Removed automatic fetch
  }

  Future<void> _getRandomTrack() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final track = await _spotifyService.getRandomTrack();
      setState(() {
        _currentTrack = track;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _playTrack() async {
    if (_currentTrack != null) {
      try {
        await _spotifyService.playTrack(_currentTrack!['uri']);
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Shuffle Song',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              )
            else if (_currentTrack != null) ...[
              if (_currentTrack!['imageUrl'] != null)
                Image.network(
                  _currentTrack!['imageUrl'],
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                _currentTrack!['name'],
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${_currentTrack!['artist']} • ${_currentTrack!['album']}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _playTrack,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _getRandomTrack,
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Shuffle'),
                  ),
                ],
              ),
            ] else
              ElevatedButton.icon(
                onPressed: _getRandomTrack,
                icon: const Icon(Icons.shuffle),
                label: const Text('Get Random Song'),
              ),
          ],
        ),
      ),
    );
  }
} 