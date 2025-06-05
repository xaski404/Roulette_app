import 'package:flutter/material.dart';
import '../services/streak_service.dart';

class StreakCalendar extends StatefulWidget {
  const StreakCalendar({super.key});

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  final StreakService _streakService = StreakService();
  final DateTime _currentDate = DateTime.now();
  late DateTime _selectedMonth;
  Map<String, bool> _monthlyActivity = {};
  int _currentStreak = 0;
  int _bestStreak = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(_currentDate.year, _currentDate.month);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final activity = await _streakService.getMonthlyActivity(
        _selectedMonth.year,
        _selectedMonth.month,
      );
      final streak = await _streakService.getCurrentStreak();
      final best = await _streakService.getBestStreak();

      setState(() {
        _monthlyActivity = activity;
        _currentStreak = streak;
        _bestStreak = best;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading streak data: $e')),
        );
      }
    }
  }

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      _loadData();
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Streak stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStreakStat(
                'Current Streak',
                _currentStreak,
                colorScheme.primary,
              ),
              _buildStreakStat(
                'Best Streak',
                _bestStreak,
                colorScheme.secondary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Month selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
              ),
              Text(
                '${_selectedMonth.year} ${_getMonthName(_selectedMonth.month)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Calendar grid
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildCalendarGrid(colorScheme, isDark),
        ],
      ),
    );
  }

  Widget _buildStreakStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(ColorScheme colorScheme, bool isDark) {
    final firstDayOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final lastDayOfMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 42, // 6 rows of 7 days
      itemBuilder: (context, index) {
        if (index < firstWeekday - 1) {
          return const SizedBox(); // Empty space for days before the 1st
        }

        final day = index - (firstWeekday - 2);
        if (day > daysInMonth) {
          return const SizedBox(); // Empty space for days after the last
        }

        final date = DateTime(_selectedMonth.year, _selectedMonth.month, day);
        final dateString = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        final isToday = date.year == _currentDate.year &&
            date.month == _currentDate.month &&
            date.day == _currentDate.day;
        final isActive = _monthlyActivity[dateString] ?? false;

        return Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isToday
                ? colorScheme.primary.withOpacity(0.2)
                : isActive
                    ? colorScheme.primary.withOpacity(0.1)
                    : Colors.transparent,
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(color: colorScheme.primary, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isToday
                    ? colorScheme.primary
                    : isActive
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withOpacity(0.5),
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
} 