import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/models/api/auth_requests.dart';
import 'package:ompay_dart/models/api/auth_responses.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<SendOtpResponse> sendOtp(String phone) async {
    final request = SendOtpRequest(phone: phone);
    final response = await _apiService.sendOtp(request);
    return SendOtpResponse.fromJson(response);
  }

  Future<VerifyOtpResponse> verifyOtp(String otp) async {
    final request = VerifyOtpRequest(otp: otp);
    final response = await _apiService.verifyOtp(request);

    if (response['status'] == true && response['data'] != null) {
      final accessToken = response['data']['access_token'];
      _apiService.setAccessToken(accessToken);
      return VerifyOtpResponse.fromJson(response);
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