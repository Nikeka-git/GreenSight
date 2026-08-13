import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../features/camera/camera_screen.dart';
import '../features/history/my_requests_screen.dart';
import '../features/request_detail/request_detail_screen.dart';
import '../features/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/camera',
          name: 'camera',
          builder: (context, state) => const CameraScreen(),
        ),
        GoRoute(
          path: '/history',
          name: 'history',
          builder: (context, state) => const MyRequestsScreen(),
          routes: [
            GoRoute(
              path: 'request/:id',
              name: 'request-detail',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return RequestDetailScreen(requestId: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    if (index == 0) {
      context.go('/camera');
    } else {
      context.go('/history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.birchCard,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(color: AppColors.divider),
            boxShadow: const [
              BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 6)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavTab(
                  label: 'Камера',
                  icon: Icons.camera_alt_outlined,
                  selectedIcon: Icons.camera_alt_rounded,
                  selected: _currentIndex == 0,
                  onTap: () => _onTap(0),
                ),
              ),
              Expanded(
                child: _NavTab(
                  label: 'История',
                  icon: Icons.history_rounded,
                  selectedIcon: Icons.history_rounded,
                  selected: _currentIndex == 1,
                  onTap: () => _onTap(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.lg),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.canopy : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              size: 22,
              color: selected ? AppColors.birch : AppColors.inkMuted,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTypography.textTheme.labelSmall?.copyWith(
                color: selected ? AppColors.birch : AppColors.inkMuted,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
