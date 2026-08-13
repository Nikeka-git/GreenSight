import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/tree_mark.dart';
import '../../providers/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String _statusMessage = 'Проверка разрешений…';

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final permissionService = ref.read(permissionServiceProvider);
    final hasPermissions = await permissionService.checkPermissions();

    if (hasPermissions) {
      _navigateToCamera();
      return;
    }

    setState(() => _statusMessage = 'Запрашиваем доступ к камере и геолокации…');
    final granted = await permissionService.requestPermissions();

    if (granted) {
      _navigateToCamera();
    } else {
      setState(() {
        _isLoading = false;
        _statusMessage =
            'Без камеры и геолокации приложение не сможет создавать заявки';
      });
    }
  }

  void _navigateToCamera() {
    if (mounted) context.go('/camera');
  }

  Future<void> _retry() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Повторный запрос разрешений…';
    });
    final granted =
        await ref.read(permissionServiceProvider).requestPermissions();
    if (granted) {
      _navigateToCamera();
    } else {
      setState(() {
        _isLoading = false;
        _statusMessage =
            'Без камеры и геолокации приложение не сможет создавать заявки';
      });
    }
  }

  Future<void> _openSettings() async {
    final permissionService = ref.read(permissionServiceProvider);
    await permissionService.openAppSettings();
    await _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canopy,
      body: Stack(
        children: [
          // Фоновая текстура "берёсты" — тонкие горизонтальные штрихи.
          // TODO(assets): при желании замените этот Container на
          // Image.asset('assets/images/birch_bark_texture.png', fit: BoxFit.cover)
          // — ищите бесшовную текстуру коры берёзы, тон тёмно-зелёный/графитовый,
          // низкий контраст, напр. на unsplash.com по запросу "birch bark dark".
          Positioned.fill(child: CustomPaint(painter: _BarkTexturePainter())),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final scale = 1.0 + _controller.value * 0.04;
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: const TreeMark(
                      size: 96,
                      color: AppColors.birch,
                      strokeWidth: 2.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'GreenSight',
                    style: AppTypography.textTheme.displaySmall
                        ?.copyWith(color: AppColors.birch),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ЦИФРОВОЙ УЧЁТ ЗЕЛЁНЫХ НАСАЖДЕНИЙ · КОСТАНАЙ',
                    textAlign: TextAlign.center,
                    style: AppTypography.mono(
                      size: 11,
                      color: AppColors.birch.withValues(alpha: 0.6),
                      weight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 56),
                  if (_isLoading) ...[
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.amber,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _statusMessage,
                      textAlign: TextAlign.center,
                      style: AppTypography.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.birch.withValues(alpha: 0.85)),
                    ),
                  ] else ...[
                    Icon(Icons.eco_outlined, color: AppColors.amber, size: 28),
                    const SizedBox(height: 12),
                    Text(
                      _statusMessage,
                      textAlign: TextAlign.center,
                      style: AppTypography.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.birch.withValues(alpha: 0.85)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _retry,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.amber,
                              foregroundColor: AppColors.ink,
                            ),
                            child: const Text('Повторить'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _openSettings,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.birch,
                              side: BorderSide(
                                  color: AppColors.birch.withValues(alpha: 0.6)),
                            ),
                            child: const Text('Настройки'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarkTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.birch.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    const gap = 22.0;
    for (double y = 0; y < size.height; y += gap) {
      final wobble = (y % (gap * 3)) / (gap * 3) * 30;
      canvas.drawLine(
        Offset(-10, y + wobble),
        Offset(size.width + 10, y - wobble + 40),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BarkTexturePainter oldDelegate) => false;
}
