import 'package:go_router/go_router.dart';

import '../features/camera_capture/camera_capture_screen.dart';
import '../features/history/my_requests_screen.dart';
import '../features/problem_description/problem_description_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    // Временно без авторизации
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CameraCaptureScreen(),
    ),
    GoRoute(
      path: '/problem-description',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ProblemDescriptionScreen(
          photoFile: extra['photoFile'],
          latitude: extra['latitude'],
          longitude: extra['longitude'],
        );
      },
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const MyRequestsScreen(),
    ),
  ],
);
