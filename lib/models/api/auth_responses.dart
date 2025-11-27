class SendOtpResponse {
  final String message;

  SendOtpResponse({required this.message});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      message: json['message'] ?? 'Code OTP envoyé par SMS',
    );
  }
}

class VerifyOtpResponse {
  final String accessToken;
  final String tokenType;

  VerifyOtpResponse({
    required this.accessToken,
    required this.tokenType,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      accessToken: json['data']['access_token'],
      tokenType: json['data']['token_type'],
    );
  }
}

class LogoutResponse {
  final String message;

  LogoutResponse({required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json['message'] ?? 'Déconnexion réussie',
    );
  }
}