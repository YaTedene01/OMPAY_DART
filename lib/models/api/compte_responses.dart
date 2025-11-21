import '../user.dart';
import '../compte.dart';
import '../qr_code.dart';
import '../transaction.dart';

class DashboardResponse {
  final User user;
  final Compte compte;
  final QrCode qrCode;
  final List<Transaction> recentTransactions;

  DashboardResponse({
    required this.user,
    required this.compte,
    required this.qrCode,
    required this.recentTransactions,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      user: User.fromJson(json['user']),
      compte: Compte.fromJson(json['compte']),
      qrCode: QrCode.fromJson(json['qr_code']),
      recentTransactions: (json['recent_transactions'] as List)
          .map((t) => Transaction.fromJson(t))
          .toList(),
    );
  }
}

class TransferResponse {
  final Map<String, dynamic> from;
  final double montant;
  final String type;

  TransferResponse({
    required this.from,
    required this.montant,
    required this.type,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      from: json['from'],
      montant: json['montant'].toDouble(),
      type: json['type'],
    );
  }
}

class PaymentResponse {
  final Map<String, dynamic> from;
  final double montant;
  final String type;

  PaymentResponse({
    required this.from,
    required this.montant,
    required this.type,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      from: json['from'],
      montant: json['montant'].toDouble(),
      type: json['type'],
    );
  }
}

class SoldeResponse {
  final String compteId;
  final double solde;
  final String devise;
  final DateTime dernierMaj;

  SoldeResponse({
    required this.compteId,
    required this.solde,
    required this.devise,
    required this.dernierMaj,
  });

  factory SoldeResponse.fromJson(Map<String, dynamic> json) {
    return SoldeResponse(
      compteId: json['compte_id'],
      solde: json['solde'].toDouble(),
      devise: json['devise'],
      dernierMaj: DateTime.parse(json['dernier_maj']),
    );
  }
}

class TransactionListResponse {
  final List<Transaction> data;
  final int total;
  final int perPage;
  final int currentPage;

  TransactionListResponse({
    required this.data,
    required this.total,
    required this.perPage,
    required this.currentPage,
  });

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) {
    return TransactionListResponse(
      data: (json['data'] as List).map((t) => Transaction.fromJson(t)).toList(),
      total: json['meta']['total'],
      perPage: json['meta']['per_page'],
      currentPage: json['meta']['current_page'],
    );
  }
}