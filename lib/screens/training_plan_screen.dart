import 'package:flutter/material.dart';
import '../services/training_plan_service.dart';
import 'exercise_detail_screen.dart';
import '../services/auth_service.dart';

class TrainingPlanScreen extends StatefulWidget {
  final String category;
  final String workoutName;

  const TrainingPlanScreen({
    super.key,
    required this.category,
    required this.workoutName,
  });

  @override
  State<TrainingPlanScreen> createState() => _TrainingPlanScreenState();
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  final TrainingPlanService _trainingPlanService = TrainingPlanService();
  List<TrainingPlan> _trainingPlans = [];
  bool _isLoading = true;
  TrainingPlan? _selectedPlan;

  @override
  void initState() {
    super.initState();
    _loadTrainingPlans();
  }

  Future<void> _loadTrainingPlans() async {
    setState(() => _isLoading = true);
    try {
      await _trainingPlanService.initializeDefaultTrainingPlans();
      final plans = await _trainingPlanService.getTrainingPlansForWorkout(
        category: widget.category,
        workoutName: widget.workoutName,
      );
      setState(() {
        _trainingPlans = plans;
        _isLoading = false;
        if (plans.isNotEmpty) {
          _selectedPlan = plans.first;
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading training plans: $e')),
        );
      }
    }
  }

  String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds sec';
    } else {
      final minutes = (seconds / 60).floor();
      final remainingSeconds = seconds % 60;
      return remainingSeconds > 0
          ? '$minutes min $remainingSeconds sec'
          : '$minutes min';
    }
  }

  Widget _buildPlanSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _trainingPlans.map((plan) {
          final isSelected = plan == _selectedPlan;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(plan.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedPlan = plan);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? null : Border.all(color: Colors.black12),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                exercise.name,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (exercise.hasVideo)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  Icons.repeat,
                  'Sets',
                  exercise.sets.toString(),
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.fitness_center,
                  'Reps',
                  exercise.reps.toString(),
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.timer,
                  'Rest between sets',
                  _formatDuration(exercise.restBetweenSets),
                ),
                if (exercise.hasVideo) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailScreen(
                              exercise: exercise,
                              exerciseIndex: index,
                              workoutName: widget.workoutName,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_circle_outline),
                      label: const Text('Watch Exercise Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Training Plan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              setState(() => _isLoading = true);
              try {
                await _trainingPlanService.resetAndInitializeTrainingPlans();
                await _loadTrainingPlans();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Training plans updated with videos!')),
                  );
                }
                final authService = AuthService();
                await authService.signOut();
              } catch (e) {
                setState(() => _isLoading = false);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating training plans: $e')),
                  );
                }
              }
            },
            tooltip: 'Update with videos',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _trainingPlans.isEmpty
              ? Center(
                  child: Text(
                    'No training plans available',
                    style: TextStyle(color: colorScheme.onBackground),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildPlanSelector(),
                    if (_selectedPlan != null) ...[
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Rest between exercises: ${_formatDuration(_selectedPlan!.restBetweenExercises)}',
                              style: TextStyle(
                                color: colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _selectedPlan!.exercises.length,
                          itemBuilder: (context, index) {
                            return _buildExerciseCard(
                              _selectedPlan!.exercises[index],
                              index,
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
    );
  }
} 