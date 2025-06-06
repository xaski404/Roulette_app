import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/travel_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'attractions_screen.dart';

class TravelScreen extends StatefulWidget {
  final String initialCategory;

  const TravelScreen({
    super.key,
    required this.initialCategory,
  });

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> with TickerProviderStateMixin {
  String? _selectedDestination;
  String? _currentPassingDestination;
  bool _isSpinning = false;
  late String _selectedCategory;
  
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
    _selectedCategory = widget.initialCategory;
    
    // Main spin animation controller
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
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

    // Initialize spin animation
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinController.addStatusListener(_handleSpinStatus);
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _updatePassingDestination() {
    if (!_isSpinning) {
      setState(() {
        _currentPassingDestination = null;
      });
      return;
    }

    final destinations = TravelService.destinations[_selectedCategory] ?? [];
    if (destinations.isEmpty) return;

    // Calculate current angle and segment
    final currentAngle = _spinAnimation.value * (2 * pi * 5); // 5 full rotations
    final normalizedAngle = currentAngle % (2 * pi);
    final currentSegment = (normalizedAngle / segmentAngle).floor() % destinations.length;

    setState(() {
      _currentPassingDestination = destinations[currentSegment].name;
    });

    // Add bounce effect near the end of the animation
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
        _currentPassingDestination = null;
        final destinations = TravelService.destinations[_selectedCategory] ?? [];
        final random = Random();
        String newDestination;
        do {
          newDestination = destinations[random.nextInt(destinations.length)].name;
        } while (destinations.length > 1 && newDestination == _selectedDestination);
        _selectedDestination = newDestination;
      });
    }
  }

  void _spinWheel() {
    if (_isSpinning) return;

    final destinations = TravelService.destinations[_selectedCategory] ?? [];
    if (destinations.isEmpty) return;

    setState(() {
      _isSpinning = true;
      _selectedDestination = null;
    });

    _spinController.reset();
    _spinController.forward();
  }

  void _showDestinationDetails(Destination destination) {
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
                  destination.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  destination.description,
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
                        target: destination.location,
                        zoom: 12,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(destination.name),
                          position: destination.location,
                          infoWindow: InfoWindow(
                            title: destination.name,
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
                  'Distance from Katowice: ${TravelService.calculateDistance(TravelService.KATOWICE_LOCATION, destination.location).toStringAsFixed(1)} km',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Navigation button
                ElevatedButton.icon(
                  onPressed: () async {
                    final url = 'https://www.google.com/maps/dir/?api=1&destination=${destination.location.latitude},${destination.location.longitude}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  icon: const Icon(Icons.directions),
                  label: const Text('Get Directions'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final destinations = TravelService.destinations[_selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(_selectedCategory),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
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
                      animation: Listenable.merge([_spinAnimation, _bounceAnimation]),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _spinAnimation.value * (2 * pi * 5) + _bounceAnimation.value,
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
                          Icons.place,
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
                        child: CustomPaint(
                          size: const Size(20, 20),
                          painter: TrianglePainter(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Selected destination display and details button
              if (_selectedDestination != null && !_isSpinning)
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
                        'Selected Destination',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _selectedDestination!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                final destination = destinations.firstWhere(
                                  (d) => d.name == _selectedDestination,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AttractionsScreen(
                                      destinationName: destination.name,
                                      location: destination.location,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.attractions),
                              label: const Text('Attractions'),
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
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                final destination = destinations.firstWhere(
                                  (d) => d.name == _selectedDestination,
                                );
                                _showDestinationDetails(destination);
                              },
                              icon: const Icon(Icons.navigation),
                              label: const Text('Navigate'),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 32),

              // Spin button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  onPressed: _isSpinning ? null : _spinWheel,
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
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => color != oldDelegate.color;
} 