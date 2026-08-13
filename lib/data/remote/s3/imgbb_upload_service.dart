import 'dart:io';

class ImgBBUploadService {
  ImgBBUploadService({required this.apiKey});
  final String apiKey;

  Future<String> uploadPhoto({
    required File file,
    required String requestId,
  }) async {
    // Заглушка – имитация задержки и возврат фейкового URL
    await Future.delayed(const Duration(seconds: 1));
    return 'https://example.com/photos/$requestId.jpg';
  }
}