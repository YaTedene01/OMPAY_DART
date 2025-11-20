class Compte {
  final String id;
  final int userId;
  final double solde;
  final String devise;
  final DateTime createdAt;
  final DateTime updatedAt;

  Compte({
    required this.id,
    required this.userId,
    required this.solde,
    required this.devise,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Compte.fromJson(Map<String, dynamic> json) {
    return Compte(
      id: json['id'],
      userId: json['user_id'] is int ? json['user_id'] : int.parse(json['user_id'].toString()),
      solde: json['solde'] is num ? (json['solde'] as num).toDouble() : double.parse(json['solde'].toString()),
      devise: json['devise'] ?? 'XOF',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'solde': solde,
      'devise': devise,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}