import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'streak_calendar.dart';

class UserMenuPanel extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onClose;

  const UserMenuPanel({
    super.key,
    required this.onLogout,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          // Panel
          Positioned(
            top: 80,
            right: 16,
            child: Container(
              width: 320,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Streak Calendar
                  const StreakCalendar(),
                  const Divider(height: 1),
                  // Logout Button
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: colorScheme.error,
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: onLogout,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 