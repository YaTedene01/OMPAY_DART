import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ompay_dart/core/message.dart';

class ApiService {
  final Dio _dio;
  String? _accessToken;
  final String baseUrl;
  static const String _tokenFileName = '.ompay_token';

  String? get accessToken => _accessToken;

  ApiService({
    required this.baseUrl,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _configureDio();
    _loadToken();
  }

  void _configureDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_accessToken != null) {
          options.headers['Authorization'] = 'Bearer $_accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response != null) {
          final statusCode = e.response!.statusCode;
          final message = Message.fromStatusCode(statusCode!);
          throw Exception(message);
        } else {
          throw Exception(Message.fromException(e));
        }
      },
    ));
  }

  void setAccessToken(String token) {
    _accessToken = token;
    _saveToken();
  }

  void clearAccessToken() {
    _accessToken = null;
    _deleteTokenFile();
  }

  void _loadToken() {
    try {
      final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      if (homeDir == null) return;

      final tokenFile = File('$homeDir/$_tokenFileName');
      if (tokenFile.existsSync()) {
        final token = tokenFile.readAsStringSync().trim();
        if (token.isNotEmpty) {
          _accessToken = token;
        }
      }
    } catch (e) {
      
    }
  }

  void _saveToken() {
    try {
      final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      if (homeDir == null || _accessToken == null) return;

      final tokenFile = File('$homeDir/$_tokenFileName');
      tokenFile.writeAsStringSync(_accessToken!);
    } catch (e) {
      
    }
  }

  void _deleteTokenFile() {
    try {
      final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      if (homeDir == null) return;

      final tokenFile = File('$homeDir/$_tokenFileName');
      if (tokenFile.existsSync()) {
        tokenFile.deleteSync();
      }
    } catch (e) {
    }
  }

  Future<Map<String, dynamic>> sendOtp(dynamic request) async {
    final data = request is Map<String, dynamic> ? request : request.toJson();
    final response = await _dio.post('/api/auth/send-otp', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp(dynamic request) async {
    final data = request is Map<String, dynamic> ? request : request.toJson();
    final response = await _dio.post('/api/auth/verify-otp', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getDashboard() async {
    final response = await _dio.get('/api/compte/dashboard');
    return response.data;
  }

  Future<Map<String, dynamic>> transfer(dynamic request) async {
    final data = request is Map<String, dynamic> ? request : request.toJson();
    final response = await _dio.post('/api/compte/transfert', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> payWithCode(dynamic request) async {
    final data = request is Map<String, dynamic> ? request : request.toJson();
    final response = await _dio.post('/api/compte/paiement', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getTransactions({int perPage = 15, String? type}) async {
    final queryParams = <String, dynamic>{'per_page': perPage};
    if (type != null) queryParams['type'] = type;

    final response = await _dio.get('/api/compte/transactions', queryParameters: queryParams);
    return response.data;
  }

  Future<Map<String, dynamic>> getSolde() async {
    final response = await _dio.get('/api/compte/solde');
    return response.data;
  }

  Future<Map<String, dynamic>> logout() async {
    final response = await _dio.post('/api/auth/logout');
    return response.data;
  }
}