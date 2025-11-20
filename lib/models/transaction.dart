class Transaction {
  final String id;
  final String compteId;
  final String type;
  final double montant;
  final String status;
  final String? counterparty;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.compteId,
    required this.type,
    required this.montant,
    required this.status,
    this.counterparty,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      compteId: json['compte_id'],
      type: json['type'],
      montant: json['montant'] is num ? (json['montant'] as num).toDouble() : double.parse(json['montant'].toString()),
      status: json['status'] ?? 'pending',
      counterparty: json['counterparty'],
      metadata: json['metadata'] != null ? Map<String, dynamic>.from(json['metadata']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'compte_id': compteId,
      'type': type,
      'montant': montant,
      'status': status,
      'counterparty': counterparty,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}