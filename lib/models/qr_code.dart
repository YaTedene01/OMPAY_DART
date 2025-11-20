class QrCode {
  final String id;
  final int userId;
  final String code;
  final Map<String, dynamic> meta;
  final DateTime createdAt;
  final DateTime updatedAt;

  QrCode({
    required this.id,
    required this.userId,
    required this.code,
    required this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QrCode.fromJson(Map<String, dynamic> json) {
    return QrCode(
      id: json['id'],
      userId: json['user_id'] is int ? json['user_id'] : int.parse(json['user_id'].toString()),
      code: json['code'],
      meta: json['meta'] != null ? Map<String, dynamic>.from(json['meta']) : {},
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'code': code,
      'meta': meta,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}