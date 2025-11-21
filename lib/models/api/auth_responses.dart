class SendAuthLinkResponse {
  final String token;
  final int expiresIn;
  final String message;

  SendAuthLinkResponse({
    required this.token,
    required this.expiresIn,
    required this.message,
  });

  factory SendAuthLinkResponse.fromJson(Map<String, dynamic> json) {
    return SendAuthLinkResponse(
      token: json['data']['token'],
      expiresIn: json['data']['expires_in'],
      message: json['data']['message'],
    );
  }
}

class ExchangeTokenResponse {
  final String accessToken;
  final String tokenType;

  ExchangeTokenResponse({
    required this.accessToken,
    required this.tokenType,
  });

  factory ExchangeTokenResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeTokenResponse(
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