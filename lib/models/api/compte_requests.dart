class TransferRequest {
  final double montant;
  final String? toPhone;
  final String? toCompteId;

  TransferRequest({
    required this.montant,
    this.toPhone,
    this.toCompteId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'montant': montant};
    if (toPhone != null) data['to_phone'] = toPhone;
    if (toCompteId != null) data['to_compte_id'] = toCompteId;
    return data;
  }
}

class PaymentRequest {
  final String codeMarchand;
  final double montant;

  PaymentRequest({
    required this.codeMarchand,
    required this.montant,
  });

  Map<String, dynamic> toJson() {
    return {
      'code_marchand': codeMarchand,
      'montant': montant,
    };
  }
}