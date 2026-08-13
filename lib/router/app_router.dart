import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/camera_capture/camera_capture_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CameraCaptureScreen(),
    ),
  ],
);