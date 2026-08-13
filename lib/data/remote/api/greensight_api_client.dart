import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

/// Thin REST client for the GreenSight backend (NestJS, prefix /api).
class GreensightApiClient {
  GreensightApiClient({required this.baseUrl});

  final String baseUrl;

  /// Upload a photo and return its server-side id (uuid).
  Future<String> uploadPhoto(File file) async {
    final uri = Uri.parse('$baseUrl/api/photos');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: _contentTypeFor(file.path),
      ));
    final response = await request.send();
    final body = await response.stream.bytesToString();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException('Upload failed: ${response.statusCode} $body');
    }
    final json = _decodeObject(body);
    return json['id'] as String;
  }

  /// Create/upsert a work request. The server runs AI analysis when the
  /// payload's status is `pendingAI`.
  Future<Map<String, dynamic>> createWorkRequest({
    required Map<String, dynamic> payload,
  }) async {
    final uri = Uri.parse('$baseUrl/api/work-requests');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    final body = response.body;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException('Create work request failed: ${response.statusCode} $body');
    }
    return _decodeObject(body);
  }

  /// Fetch work requests created by [userId] (used to reconcile local state).
  Future<List<Map<String, dynamic>>> fetchMyWorkRequests(String userId) async {
    final uri = Uri.parse(
      '$baseUrl/api/work-requests?createdByUserId=${Uri.encodeQueryComponent(userId)}',
    );
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException('Fetch work requests failed: ${response.statusCode} $body');
    }
    final decoded = jsonDecode(body);
    if (decoded is! List) {
      throw ApiException('Unexpected response for work requests list');
    }
    return decoded.cast<Map<String, dynamic>>();
  }

  Map<String, dynamic> _decodeObject(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw ApiException('Unexpected response shape');
    }
    return decoded;
  }
}

MediaType _contentTypeFor(String path) {
  final mime = lookupMimeType(path) ?? 'application/octet-stream';
  final slash = mime.indexOf('/');
  return MediaType(
    slash == -1 ? mime : mime.substring(0, slash),
    slash == -1 ? 'octet-stream' : mime.substring(slash + 1),
  );
}

class ApiException implements Exception {
  ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}
