import 'package:flutter/material.dart';
import '../services/exercise_video_service.dart';
import '../widgets/exercise_video_player.dart';

class ExerciseVideoManagerScreen extends StatefulWidget {
  const ExerciseVideoManagerScreen({super.key});

  @override
  State<ExerciseVideoManagerScreen> createState() => _ExerciseVideoManagerScreenState();
}

class _ExerciseVideoManagerScreenState extends State<ExerciseVideoManagerScreen> {
  final ExerciseVideoService _videoService = ExerciseVideoService();
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> _videos = [];
  List<Map<String, dynamic>> _filteredVideos = [];
  bool _isLoading = true;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadVideos() async {
    setState(() => _isLoading = true);
    try {
      final videos = await _videoService.getAllExerciseVideos();
      setState(() {
        _videos = videos;
        _filteredVideos = videos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading videos: $e')),
        );
      }
    }
  }

  void _filterVideos(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
      if (searchTerm.isEmpty) {
        _filteredVideos = _videos;
      } else {
        _filteredVideos = _videos.where((video) {
          final exerciseName = video['exerciseName']?.toString().toLowerCase() ?? '';
          final category = video['category']?.toString().toLowerCase() ?? '';
          final workoutName = video['workoutName']?.toString().toLowerCase() ?? '';
          final searchLower = searchTerm.toLowerCase();
          
          return exerciseName.contains(searchLower) ||
                 category.contains(searchLower) ||
                 workoutName.contains(searchLower);
        }).toList();
      }
    });
  }

  void _showAddVideoDialog() {
    final exerciseController = TextEditingController();
    final urlController = TextEditingController();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    final workoutController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise Video'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                decoration: const InputDecoration(
                  labelText: 'Exercise Name *',
                  hintText: 'e.g., Barbell Back Squats',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  labelText: 'YouTube URL *',
                  hintText: 'https://www.youtube.com/watch?v=...',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Video Title (Optional)',
                  hintText: 'e.g., Proper Form Tutorial',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Video Description (Optional)',
                  hintText: 'Brief description of the video content',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category (Optional)',
                  hintText: 'e.g., Strength training at the gym',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: workoutController,
                decoration: const InputDecoration(
                  labelText: 'Workout Name (Optional)',
                  hintText: 'e.g., Full body workout',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (exerciseController.text.isEmpty || urlController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exercise name and URL are required')),
                );
                return;
              }

              try {
                await _videoService.addExerciseVideo(
                  exerciseName: exerciseController.text,
                  youtubeVideoUrl: urlController.text,
                  videoTitle: titleController.text.isEmpty ? null : titleController.text,
                  videoDescription: descriptionController.text.isEmpty ? null : descriptionController.text,
                  category: categoryController.text.isEmpty ? null : categoryController.text,
                  workoutName: workoutController.text.isEmpty ? null : workoutController.text,
                );

                Navigator.pop(context);
                _loadVideos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Video added successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error adding video: $e')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showVideoPreview(Map<String, dynamic> video) {
    final videoId = _extractVideoId(video['youtubeVideoUrl']);
    if (videoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid YouTube URL')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      video['exerciseName'] ?? 'Exercise Video',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ExerciseVideoPlayer(
                  videoId: videoId,
                  title: video['videoTitle'],
                  description: video['videoDescription'],
                  autoPlay: true,
                  showControls: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _extractVideoId(String? url) {
    if (url == null || url.isEmpty) return null;
    
    final patterns = [
      RegExp(r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtube\.com\/watch\?.*v=([a-zA-Z0-9_-]{11})'),
    ];
    
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null) {
        return match.group(1);
      }
    }
    
    return null;
  }

  void _deleteVideo(Map<String, dynamic> video) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: Text('Are you sure you want to delete the video for "${video['exerciseName']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _videoService.deleteExerciseVideo(video['exerciseName']);
                Navigator.pop(context);
                _loadVideos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Video deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting video: $e')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, dynamic> video) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasValidVideo = _extractVideoId(video['youtubeVideoUrl']) != null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: hasValidVideo ? colorScheme.primary : colorScheme.outline,
          child: Icon(
            hasValidVideo ? Icons.play_circle_outline : Icons.error_outline,
            color: hasValidVideo ? colorScheme.onPrimary : colorScheme.onSurface,
          ),
        ),
        title: Text(
          video['exerciseName'] ?? 'Unknown Exercise',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (video['category'] != null)
              Text(
                'Category: ${video['category']}',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            if (video['workoutName'] != null)
              Text(
                'Workout: ${video['workoutName']}',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            if (!hasValidVideo)
              Text(
                'Invalid YouTube URL',
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'preview':
                _showVideoPreview(video);
                break;
              case 'delete':
                _deleteVideo(video);
                break;
            }
          },
          itemBuilder: (context) => [
            if (hasValidVideo)
              const PopupMenuItem(
                value: 'preview',
                child: Row(
                  children: [
                    Icon(Icons.play_circle_outline),
                    SizedBox(width: 8),
                    Text('Preview'),
                  ],
                ),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
        onTap: hasValidVideo ? () => _showVideoPreview(video) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Exercise Videos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showAddVideoDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _filterVideos,
              decoration: InputDecoration(
                hintText: 'Search exercises, categories, or workouts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchTerm.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _filterVideos('');
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredVideos.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.video_library_outlined,
                              size: 64,
                              color: colorScheme.onSurface.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchTerm.isEmpty
                                  ? 'No exercise videos yet'
                                  : 'No videos found for "$_searchTerm"',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_searchTerm.isEmpty)
                              Text(
                                'Add your first exercise video to get started',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredVideos.length,
                        itemBuilder: (context, index) {
                          return _buildVideoCard(_filteredVideos[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }
} 