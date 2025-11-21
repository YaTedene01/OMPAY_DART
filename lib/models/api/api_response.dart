class ApiResponse<T> {
  final bool status;
  final String? message;
  final T? data;
  final dynamic errors;

  ApiResponse({
    required this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic)? fromJsonData) {
    return ApiResponse<T>(
      status: json['status'] ?? false,
      message: json['message'],
      data: json['data'] != null && fromJsonData != null ? fromJsonData(json['data']) : null,
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
      'errors': errors,
    };
  }
}