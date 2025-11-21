import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/models/api/api_models.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<SendAuthLinkResponse> sendAuthLink(String phone) async {
    final request = SendAuthLinkRequest(phone: phone);
    final response = await _apiService.sendAuthLink(request);
    return SendAuthLinkResponse.fromJson(response);
  }

  Future<ExchangeTokenResponse> exchangeToken(String tempToken) async {
    final request = ExchangeTokenRequest(tempToken: tempToken);
    final response = await _apiService.exchangeToken(request);

    if (response['status'] == true && response['data'] != null) {
      final accessToken = response['data']['access_token'];
      _apiService.setAccessToken(accessToken);
      return ExchangeTokenResponse.fromJson(response);
    }

    throw Exception('Échec de l\'authentification');
  }

  Future<LogoutResponse> logout() async {
    try {
      final response = await _apiService.logout();
      _apiService.clearAccessToken();
      return LogoutResponse.fromJson(response);
    } catch (e) {
      _apiService.clearAccessToken();
      rethrow;
    }
  }

  bool isAuthenticated() {
    return _apiService.accessToken != null;
  }
}