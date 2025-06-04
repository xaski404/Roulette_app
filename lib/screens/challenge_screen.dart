class ChallengeScreen extends StatefulWidget {
  final String category;
  final List<String> challenges;
  final List<Color> pieColors;
  const ChallengeScreen({super.key, required this.category, required this.challenges, required this.pieColors});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> with TickerProviderStateMixin {
  String? _selectedChallenge;
  String? _currentPassingChallenge;
  bool _isSpinning = false;
  
  // Controllers for different animation aspects
  late AnimationController _spinController;
  late AnimationController _bounceController;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;
  
  // Constants for animation
  static const int numSegments = 12;
  static const double segmentAngle = 2 * pi / numSegments;

  @override
  void initState() {
    super.initState();
    
    // Main spin animation controller - exactly 2 seconds like food section
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Bounce effect controller - 100ms for quick bounce
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Bounce animation - matches food section's bounce intensity
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: segmentAngle / 4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    // Initialize spin animation with easeOutCubic for realistic deceleration
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Add listeners for animation updates
    _spinAnimation.addListener(_updatePassingChallenge);
    _spinAnimation.addStatusListener(_handleSpinStatus);
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    _currentPassingChallenge = null;
    super.dispose();
  }

  void _updatePassingChallenge() {
    if (!_isSpinning || widget.challenges.isEmpty) {
      setState(() {
        _currentPassingChallenge = null;
      });
      return;
    }

    // Calculate current angle and segment - 5 full rotations like food section
    final currentAngle = _spinAnimation.value * (2 * pi * 5);
    final normalizedAngle = currentAngle % (2 * pi);
    final currentSegment = (normalizedAngle / segmentAngle).floor() % widget.challenges.length;

    // Update passing challenge with smooth transitions
    if (mounted) {
      setState(() {
        _currentPassingChallenge = widget.challenges[currentSegment];
      });
    }

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
    if (status == AnimationStatus.completed && mounted) {
      setState(() {
        _isSpinning = false;
        _currentPassingChallenge = null;
      });
    }
  }

  void _selectRandomChallenge() {
    if (widget.challenges.isEmpty || _isSpinning) return;
    
    setState(() {
      _isSpinning = true;
      final random = Random();
      String newChallenge;
      do {
        newChallenge = widget.challenges[random.nextInt(widget.challenges.length)];
      } while (widget.challenges.length > 1 && newChallenge == _selectedChallenge);
      _selectedChallenge = newChallenge;

      // Reset and start animations
      _spinController.reset();
      _spinController.forward();
    });
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Roulette wheel with selector - exact same dimensions as food section
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
                                      color: widget.pieColors[i % widget.pieColors.length],
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
                    // Selector indicator
                    Positioned(
                      top: -10,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: isDark ? null : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Passing challenges display - matches food section's style
              SizedBox(
                height: 40,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: _isSpinning && _currentPassingChallenge != null
                      ? Container(
                          key: ValueKey(_currentPassingChallenge),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 32,
                          ),
                          child: Text(
                            _currentPassingChallenge!,
                            style: TextStyle(
                              fontSize: 18,
                              color: colorScheme.onBackground.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(
                          key: const ValueKey('empty'),
                          height: 40,
                        ),
                ),
              ),

              // Selected challenge display - matches food section's style
              if (_selectedChallenge != null && !_isSpinning)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark ? null : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Wylosowane wyzwanie:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _selectedChallenge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 40),

              // Random selection button - matches food section's style
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  onPressed: widget.challenges.isEmpty || _isSpinning ? null : _selectRandomChallenge,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: _isSpinning
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'LOSUJ',
                          style: TextStyle(
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