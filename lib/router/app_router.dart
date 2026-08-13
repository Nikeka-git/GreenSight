import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/camera/camera_screen.dart';
import '../features/history/my_requests_screen.dart';
import '../features/request_detail/request_detail_screen.dart';
import '../features/splash/splash_screen.dart';

final router = GoRouter(
  initialLocation: '/splash', // <-- меняем
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Используем context из build
          if (index == 0) {
            context.go('/camera');
          } else {
            context.go('/history');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Камера',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История',
          ),
        ],
      ),
    );
  }
}