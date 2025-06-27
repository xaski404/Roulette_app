import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import '../services/entertainment_service.dart';
import 'package:url_launcher/url_launcher.dart';

class EntertainmentScreen extends StatefulWidget {
  final String category;
  final bool isOutdoor;

  const EntertainmentScreen({
    super.key,
    required this.category,
    required this.isOutdoor,
  });

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen>
    with TickerProviderStateMixin {
  String? _selectedRange;
  String? _selectedActivity;
  bool _isSpinning = false;
  late AnimationController _spinController;
  late AnimationController _bounceController;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;

  static const int numSegments = 12;
  static const double segmentAngle = 2 * pi / numSegments;
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
  ];

  List<String> get _currentOptions {
    if (widget.isOutdoor) {
      if (_selectedRange == null) return [];
      return EntertainmentService.outdoorEntertainment[_selectedRange]!
          .map((place) => place['name'] as String)
          .toList();
    }

    switch (widget.category) {
      case EntertainmentService.GAME:
        return EntertainmentService.games.values
            .expand((games) => games)
            .toList();
      case EntertainmentService.MOVIE:
        return EntertainmentService.movies.values
            .expand((movies) => movies)
            .toList();
      case EntertainmentService.TV_SERIES:
        return EntertainmentService.tvSeries.values
            .expand((series) => series)
            .toList();
      default:
        return [];
    }
  }

  @override
  void initState() {
    super.initState();
    
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: segmentAngle / 4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinAnimation.addListener(_updatePassingActivity);
    _spinAnimation.addStatusListener(_handleSpinStatus);

    if (widget.isOutdoor) {
      _selectedRange = EntertainmentService.RANGE_10;
    }
  }

  void _updatePassingActivity() {
    if (!_isSpinning) return;

    final options = _currentOptions;
    if (options.isEmpty) return;

    final currentAngle = _spinAnimation.value * (2 * pi * 5);
    final normalizedAngle = currentAngle % (2 * pi);
    final currentSegment = (normalizedAngle / segmentAngle).floor() % options.length;

    if (_spinAnimation.value > 0.8) {
      final shouldBounce = (normalizedAngle / (segmentAngle / 2)).floor() % 2 == 0;
      
      if (shouldBounce && !_bounceController.isAnimating) {
        _bounceController.forward().then((_) {
          if (mounted) {
            _bounceController.reverse();
          }
        });
      }
    }
  }

  void _handleSpinStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isSpinning = false;
        final options = _currentOptions;
        final random = Random();
        String newActivity;
        do {
          newActivity = options[random.nextInt(options.length)];
        } while (options.length > 1 && newActivity == _selectedActivity);
        _selectedActivity = newActivity;
      });
    }
  }

  void _spinWheel() {
    if (_isSpinning) return;
    
    final options = _currentOptions;
    if (options.isEmpty) return;

    setState(() {
      _isSpinning = true;
      _selectedActivity = null;
    });

    // Generate a random number of full rotations (between 3 and 5)
    final random = Random();
    final fullRotations = 3 + random.nextInt(3);
    
    // Generate a random final position
    final randomIndex = random.nextInt(options.length);
    final segmentAngle = 2 * pi / options.length;
    final targetAngle = randomIndex * segmentAngle + (segmentAngle / 2);
    
    // Calculate the total rotation needed
    final totalRotation = (fullRotations * 2 * pi) + targetAngle;
    
    // Create a new animation with the random target
    _spinAnimation = Tween<double>(begin: 0, end: totalRotation).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinController.forward(from: 0);
  }

  void _showOutdoorDetails(Map<String, dynamic> place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: scrollController,
              children: [
                Text(
                  place['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  place['description'],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),

                // Map preview
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: place['location'],
                        zoom: 12,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(place['name']),
                          position: place['location'],
                          infoWindow: InfoWindow(
                            title: place['name'],
                          ),
                        ),
                      },
                      liteModeEnabled: true,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Distance from Katowice
                Text(
                  'Distance from Katowice: ${EntertainmentService.calculateDistance(
                    EntertainmentService.KATOWICE_LOCATION,
                    place['location'],
                  ).toStringAsFixed(1)} km',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                // Activities
                const Text(
                  'Available Activities:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...List<Widget>.from(
                  (place['activities'] as List).map(
                    (activity) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            activity,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Navigate button (use mapsQuery if present)
                if (place['mapsQuery'] != null || place['name'] != null)
                  ElevatedButton.icon(
                    onPressed: () async {
                      final query = place['mapsQuery'] ?? place['name'];
                      final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not launch Google Maps.')),
                        );
                      }
                    },
                    icon: const Icon(Icons.navigation),
                    label: const Text('Navigate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showNearbyLocations(String locationType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationType == 'cinema' ? 'Nearby Cinemas' : 'Nearby Arcades',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: EntertainmentService.KATOWICE_LOCATION,
                        zoom: 11,
                      ),
                      circles: {
                        Circle(
                          circleId: const CircleId('searchRadius'),
                          center: EntertainmentService.KATOWICE_LOCATION,
                          radius: 30000, // 30 km in meters
                          fillColor: Colors.blue.withOpacity(0.1),
                          strokeColor: Colors.blue,
                          strokeWidth: 1,
                        ),
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('katowice'),
                          position: EntertainmentService.KATOWICE_LOCATION,
                          infoWindow: const InfoWindow(
                            title: 'Katowice',
                          ),
                        ),
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Showing locations within 30 km of Katowice',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          if (widget.isOutdoor) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: EntertainmentService.distanceRanges.map((range) {
                  return ChoiceChip(
                    label: Text(range),
                    selected: _selectedRange == range,
                    onSelected: (selected) {
                      setState(() {
                        _selectedRange = selected ? range : null;
                        _selectedActivity = null;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wheel container
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 250,
                      height: 270,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedBuilder(
                            animation: Listenable.merge([_spinAnimation, _bounceAnimation]),
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _spinAnimation.value * (2 * pi * 5) + _bounceAnimation.value,
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    shape: BoxShape.circle,
                                    boxShadow: isDark ? null : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: PieChart(
                                      PieChartData(
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 50,
                                        sections: List.generate(
                                          numSegments,
                                          (i) => PieChartSectionData(
                                            color: pieColors[i % pieColors.length],
                                            value: 1,
                                            title: '',
                                            radius: 90,
                                            showTitle: false,
                                          ),
                                        ),
                                        borderData: FlBorderData(show: false),
                                      ),
                                    ),
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
                                widget.category == EntertainmentService.GAME ? Icons.sports_esports :
                                widget.category == EntertainmentService.MOVIE ? Icons.movie :
                                widget.category == EntertainmentService.TV_SERIES ? Icons.tv :
                                widget.category == EntertainmentService.OUTDOOR ? Icons.park :
                                Icons.games,
                                color: colorScheme.primary,
                                size: 32,
                              ),
                            ),
                          ),
                          // Selector triangle
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
                  ),

                  // Selected activity display
                  if (_selectedActivity != null && !_isSpinning)
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
                            'Selected Activity',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedActivity!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (widget.isOutdoor)
                            ElevatedButton.icon(
                              onPressed: () {
                                final place = EntertainmentService
                                    .outdoorEntertainment[_selectedRange]!
                                    .firstWhere((p) => p['name'] == _selectedActivity);
                                _showOutdoorDetails(place);
                              },
                              icon: const Icon(Icons.info_outline),
                              label: const Text('View Details'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: colorScheme.onPrimaryContainer,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          if (widget.category == EntertainmentService.MOVIE)
                            ElevatedButton.icon(
                              onPressed: () => _showNearbyLocations('cinema'),
                              icon: const Icon(Icons.movie_outlined),
                              label: const Text('Watch in Cinema'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: colorScheme.onPrimaryContainer,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          if (widget.category == EntertainmentService.GAME)
                            ElevatedButton.icon(
                              onPressed: () => _showNearbyLocations('arcade'),
                              icon: const Icon(Icons.gamepad_outlined),
                              label: const Text('Play at an Arcade'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: colorScheme.onPrimaryContainer,
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

                  const SizedBox(height: 32),

                  // Spin button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ElevatedButton(
                      onPressed: _currentOptions.isEmpty || _isSpinning ? null : _spinWheel,
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
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 