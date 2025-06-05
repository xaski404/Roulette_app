import 'package:flutter/material.dart';
import 'dart:math';
import '../services/music_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicCategoryDetailScreen extends StatefulWidget {
  final String category;

  const MusicCategoryDetailScreen({
    super.key,
    required this.category,
  });

  @override
  State<MusicCategoryDetailScreen> createState() => _MusicCategoryDetailScreenState();
}

class _MusicCategoryDetailScreenState extends State<MusicCategoryDetailScreen> with TickerProviderStateMixin {
  final MusicService _musicService = MusicService();
  List<String> _musicOptions = [];
  String? _selectedOption;
  String? _currentPassingOption;
  bool _isLoading = true;
  bool _isSpinning = false;
  
  // Controllers for different animation aspects
  late AnimationController _spinController;
  late AnimationController _bounceController;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;
  
  // Constants for animation
  static const int numSegments = 12;
  static const double segmentAngle = 2 * pi / numSegments;
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
  ];

  @override
  void initState() {
    super.initState();
    
    // Main spin animation controller
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Bounce effect controller
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Bounce animation
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: segmentAngle / 4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    // Spin animation
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinController.addStatusListener(_handleSpinStatus);
    _loadMusicOptions();
  }

  void _handleSpinStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      setState(() {
        _isSpinning = false;
        _currentPassingOption = null;
      });
    }
  }

  Future<void> _loadMusicOptions() async {
    setState(() => _isLoading = true);
    try {
      final options = await _musicService.getMusicOptionsForCategory(widget.category);
      setState(() {
        _musicOptions = options;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading music options: $e')),
        );
      }
    }
  }

  void _selectRandomOption() {
    if (_musicOptions.isEmpty || _isSpinning) return;
    
    setState(() {
      _isSpinning = true;
      final random = Random();
      String newOption;
      do {
        newOption = _musicOptions[random.nextInt(_musicOptions.length)];
      } while (_musicOptions.length > 1 && newOption == _selectedOption);
      _selectedOption = newOption;

      // Reset and start animations
      _spinController.reset();
      _spinController.forward();
    });
  }

  Future<void> _openSpotify() async {
    if (_selectedOption == null) return;

    final url = _musicService.getSpotifyUrl(widget.category, _selectedOption!);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open Spotify')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Roulette wheel with selector
                    SizedBox(
                      width: 250,
                      height: 270,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Spinning wheel
                          AnimatedBuilder(
                            animation: _spinAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _spinAnimation.value * 2 * pi * 4,
                                child: PieChart(
                                  PieChartData(
                                    sections: _musicOptions.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final option = entry.value;
                                      return PieChartSectionData(
                                        value: 1,
                                        title: '',
                                        color: pieColors[index % pieColors.length],
                                        radius: 100,
                                      );
                                    }).toList(),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    startDegreeOffset: -90,
                                  ),
                                ),
                              );
                            },
                          ),
                          // Center circle
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark ? Colors.white24 : Colors.black12,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.music_note,
                                color: colorScheme.primary,
                                size: 32,
                              ),
                            ),
                          ),
                          // Selector arrow
                          Positioned(
                            top: -10,
                            child: Transform.rotate(
                              angle: pi,
                              child: Icon(
                                Icons.play_arrow,
                                color: colorScheme.primary,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Spin button
                    ElevatedButton(
                      onPressed: _isSpinning ? null : _selectRandomOption,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        _isSpinning ? 'Spinning...' : 'Spin the Wheel',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Selected option display
                    if (_selectedOption != null) ...[
                      Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: isDark ? null : Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Selected ${widget.category}',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _selectedOption!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Spotify button
                            ElevatedButton.icon(
                              onPressed: _openSpotify,
                              icon: const Icon(Icons.play_circle_filled),
                              label: const Text('Listen on Spotify'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1DB954), // Spotify green
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    super.dispose();
  }
} 