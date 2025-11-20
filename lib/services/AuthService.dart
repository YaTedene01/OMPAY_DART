import 'package:ompay_dart/core/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<Map<String, dynamic>> sendAuthLink(String phone) async {
    return await _apiService.sendAuthLink(phone);
  }

  Future<Map<String, dynamic>> exchangeToken(String tempToken) async {
    final response = await _apiService.exchangeToken(tempToken);

    if (response['status'] == true && response['data'] != null) {
      final accessToken = response['data']['access_token'];
      _apiService.setAccessToken(accessToken);
      return response;
    }

    throw Exception('Échec de l\'authentification');
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _apiService.logout();
      _apiService.clearAccessToken();
      return response;
    } catch (e) {
      // Même en cas d'erreur, on nettoie le token local
      _apiService.clearAccessToken();
      rethrow;
    }
  }

  bool isAuthenticated() {
    // We can't easily check token validity without making a request
    // This is a simple check - in a real app you'd validate the token
    return _apiService.accessToken != null;
  }
}