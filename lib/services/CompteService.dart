import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/models/compte.dart';
import 'package:ompay_dart/models/transaction.dart';
import 'package:ompay_dart/models/user.dart';
import 'package:ompay_dart/models/qr_code.dart';

class CompteService {
  final ApiService _apiService;

  CompteService(this._apiService);

  Future<Map<String, dynamic>> getDashboard() async {
    final response = await _apiService.getDashboard();

    if (response['status'] == true && response['data'] != null) {
      final data = response['data'];

      return {
        'user': User.fromJson(data['user']),
        'compte': Compte.fromJson(data['compte']),
        'qr_code': QrCode.fromJson(data['qr_code']),
        'recent_transactions': (data['recent_transactions'] as List)
            .map((t) => Transaction.fromJson(t))
            .toList(),
      };
    }

    throw Exception('Erreur lors de la récupération du tableau de bord');
  }

  Future<Map<String, dynamic>> transfer({
    String? toPhone,
    String? toCompteId,
    required double montant,
  }) async {
    final Map<String, dynamic> data = {'montant': montant};
    if (toPhone != null) data['to_phone'] = toPhone;
    if (toCompteId != null) data['to_compte_id'] = toCompteId;

    return await _apiService.transfer(data);
  }

  Future<Map<String, dynamic>> payWithCode(String codeMarchand, double montant) async {
    return await _apiService.payWithCode(codeMarchand, montant);
  }

  Future<List<Transaction>> getTransactions({int perPage = 15, String? type}) async {
    final response = await _apiService.getTransactions(perPage: perPage, type: type);

    if (response['status'] == true && response['data'] != null) {
      return (response['data'] as List)
          .map((t) => Transaction.fromJson(t))
          .toList();
    }

    return [];
  }

  Future<Map<String, dynamic>> getBalance() async {
    return await _apiService.getBalance();
  }

  Future<String> getUserInfoByAccountId(String accountId) async {
    try {

      return accountId;
    } catch (e) {
      return 'Utilisateur inconnu';
    }
  }
}