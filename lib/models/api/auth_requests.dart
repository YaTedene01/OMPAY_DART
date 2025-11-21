class SendAuthLinkRequest {
  final String phone;

  SendAuthLinkRequest({required this.phone});

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }
}

class ExchangeTokenRequest {
  final String tempToken;

  ExchangeTokenRequest({required this.tempToken});

  Map<String, dynamic> toJson() {
    return {'temp_token': tempToken};
  }
}