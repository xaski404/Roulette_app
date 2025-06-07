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

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final authService = AuthService();

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
                  // User greeting
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorScheme.primary.withOpacity(0.1),
                          radius: 20,
                          child: Icon(
                            Icons.person,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_getTimeBasedGreeting()}, ${authService.currentUser?.email?.split('@')[0] ?? 'User'}',
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                authService.currentUser?.email ?? '',
                                style: TextStyle(
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Streak Calendar
                  const StreakCalendar(),
                  const Divider(height: 1),
                  // Menu Items
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