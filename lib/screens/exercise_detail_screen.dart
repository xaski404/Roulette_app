import 'package:flutter/material.dart';
import '../services/training_plan_service.dart';
import '../widgets/exercise_video_player.dart';
import '../services/exercise_video_service.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final int exerciseIndex;
  final String workoutName;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
    required this.exerciseIndex,
    required this.workoutName,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  bool _isVideoPlaying = false;
  Map<String, dynamic>? _firestoreVideoData;
  bool _isLoadingVideo = true;

  @override
  void initState() {
    super.initState();
    _fetchFirestoreVideo();
  }

  Future<void> _fetchFirestoreVideo() async {
    setState(() => _isLoadingVideo = true);
    final videoService = ExerciseVideoService();
    final videoData = await videoService.getExerciseVideo(widget.exercise.name);
    if (mounted) {
      setState(() {
        _firestoreVideoData = videoData;
        _isLoadingVideo = false;
      });
    }
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds seconds';
    } else {
      final minutes = (seconds / 60).floor();
      final remainingSeconds = seconds % 60;
      return remainingSeconds > 0
          ? '$minutes minutes $remainingSeconds seconds'
          : '$minutes minutes';
    }
  }

  Widget _buildExerciseHeader() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    '${widget.exerciseIndex + 1}',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.workoutName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDetails() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exercise Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            Icons.repeat,
            'Sets',
            '${widget.exercise.sets}',
            colorScheme,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.fitness_center,
            'Reps',
            '${widget.exercise.reps}',
            colorScheme,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            Icons.timer,
            'Rest Between Sets',
            _formatDuration(widget.exercise.restBetweenSets),
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    final colorScheme = Theme.of(context).colorScheme;
    if (_isLoadingVideo) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    // Najpierw sprawdź, czy jest film w Firestore
    final firestoreVideo = _firestoreVideoData;
    final hasFirestoreVideo = firestoreVideo != null &&
      firestoreVideo['youtubeVideoUrl'] != null &&
      firestoreVideo['youtubeVideoUrl'].toString().isNotEmpty;

    final videoUrl = hasFirestoreVideo
        ? firestoreVideo['youtubeVideoUrl'] as String
        : widget.exercise.youtubeVideoUrl;
    final videoTitle = hasFirestoreVideo
        ? firestoreVideo['videoTitle'] as String?
        : widget.exercise.videoTitle;
    final videoDescription = hasFirestoreVideo
        ? firestoreVideo['videoDescription'] as String?
        : widget.exercise.videoDescription;

    String? extractVideoId(String? url) {
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

    final videoId = extractVideoId(videoUrl);
    if (videoId == null) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 48,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No instructional video available for this exercise.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You can try refreshing the video data.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _fetchFirestoreVideo,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Video Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exercise Demonstration',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          ExerciseVideoPlayer(
            videoId: videoId,
            title: videoTitle,
            description: videoDescription,
            autoPlay: true,
            showControls: true,
            onVideoEnd: () {
              setState(() => _isVideoPlaying = false);
            },
            onVideoError: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Failed to load video'),
                  backgroundColor: colorScheme.error,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Exercise Tips',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            'Focus on proper form and technique',
            colorScheme,
          ),
          _buildTipItem(
            'Breathe steadily throughout the movement',
            colorScheme,
          ),
          _buildTipItem(
            'Maintain control during both phases of the exercise',
            colorScheme,
          ),
          _buildTipItem(
            'Listen to your body and adjust intensity as needed',
            colorScheme,
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text('Exercise ${widget.exerciseIndex + 1}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (widget.exercise.hasVideo)
            IconButton(
              onPressed: () {
                // Could add a fullscreen video option here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Video controls available in player'),
                    backgroundColor: colorScheme.primary,
                  ),
                );
              },
              icon: const Icon(Icons.fullscreen),
            ),
        ],
      ),
      body: isDesktop
          ? _buildDesktopLayout()
          : _buildMobileLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildExerciseHeader(),
          _buildVideoSection(),
          _buildExerciseDetails(),
          _buildTipsSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Video and details
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildExerciseHeader(),
                _buildVideoSection(),
                _buildTipsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // Right side - Exercise details
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(16),
            child: _buildExerciseDetails(),
          ),
        ),
      ],
    );
  }
} 