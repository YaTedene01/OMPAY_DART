class SendOtpRequest {
  final String phone;

  SendOtpRequest({required this.phone});

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }
}

class VerifyOtpRequest {
  final String otp;

  VerifyOtpRequest({required this.otp});

  Map<String, dynamic> toJson() {
    return {'otp': otp};
  }
}