import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseVideoPlayer extends StatefulWidget {
  final String videoId;
  final String? title;
  final String? description;
  final bool autoPlay;
  final bool showControls;
  final double? aspectRatio;
  final VoidCallback? onVideoEnd;
  final VoidCallback? onVideoError;

  const ExerciseVideoPlayer({
    super.key,
    required this.videoId,
    this.title,
    this.description,
    this.autoPlay = true,
    this.showControls = true,
    this.aspectRatio,
    this.onVideoEnd,
    this.onVideoError,
  });

  @override
  State<ExerciseVideoPlayer> createState() => _ExerciseVideoPlayerState();
}

class _ExerciseVideoPlayerState extends State<ExerciseVideoPlayer> {
  YoutubePlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    try {
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(
          autoPlay: widget.autoPlay,
          mute: false,
          enableCaption: true,
          captionLanguage: 'en',
          isLive: false,
          forceHD: true,
          hideControls: !widget.showControls,
          showLiveFullscreenButton: false,
          loop: false,
          controlsVisibleAtStart: widget.showControls,
        ),
      );

      _controller!.addListener(_onPlayerStateChange);
      setState(() => _isInitialized = true);
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Failed to initialize video player: $e';
      });
      widget.onVideoError?.call();
    }
  }

  void _onPlayerStateChange() {
    if (_controller == null) return;

    final playerState = _controller!.value.playerState;
    
    if (playerState == PlayerState.ended) {
      widget.onVideoEnd?.call();
    } else if (playerState == PlayerState.unStarted) {
      // Handle unstarted state if needed
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      height: widget.aspectRatio != null 
          ? MediaQuery.of(context).size.width / widget.aspectRatio!
          : 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Video Unavailable',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _hasError = false;
                _errorMessage = '';
              });
              _initializeController();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: double.infinity,
      height: widget.aspectRatio != null 
          ? MediaQuery.of(context).size.width / widget.aspectRatio!
          : 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading video...'),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isInitialized || _controller == null) {
      return _buildLoadingWidget();
    }

    if (_hasError) {
      return _buildErrorWidget();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Theme.of(context).colorScheme.primary,
          progressColors: ProgressBarColors(
            playedColor: Theme.of(context).colorScheme.primary,
            handleColor: Theme.of(context).colorScheme.primary,
          ),
          onReady: () {
            // Video is ready to play
          },
          onEnded: (YoutubeMetaData metaData) {
            widget.onVideoEnd?.call();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final aspectRatio = widget.aspectRatio ?? (isDesktop ? 16 / 9 : 4 / 3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        AspectRatio(
          aspectRatio: aspectRatio,
          child: _buildVideoPlayer(),
        ),
        if (widget.description != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
} 