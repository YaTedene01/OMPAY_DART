import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/models/api/api_models.dart';

class CompteService {
  final ApiService _apiService;

  CompteService(this._apiService);

  Future<DashboardResponse> getDashboard() async {
    final response = await _apiService.getDashboard();
    return DashboardResponse.fromJson(response['data']);
  }

  Future<TransferResponse> transfer({
    String? toPhone,
    String? toCompteId,
    required double montant,
  }) async {
    final request = TransferRequest(
      montant: montant,
      toPhone: toPhone,
      toCompteId: toCompteId,
    );
    final response = await _apiService.transfer(request);
    return TransferResponse.fromJson(response);
  }

  Future<PaymentResponse> paiement(String codeMarchand, double montant) async {
    final request = PaymentRequest(
      codeMarchand: codeMarchand,
      montant: montant,
    );
    final response = await _apiService.payWithCode(request);
    return PaymentResponse.fromJson(response);
  }

  Future<TransactionListResponse> getTransactions({int perPage = 15, String? type}) async {
    final response = await _apiService.getTransactions(perPage: perPage, type: type);
    return TransactionListResponse.fromJson(response);
  }

  Future<SoldeResponse> getSolde() async {
    final response = await _apiService.getSolde();
    return SoldeResponse.fromJson(response);
  }

  Future<String> getUserInfoByAccountId(String accountId) async {
    try {
      return accountId;
    } catch (e) {
      return 'Utilisateur inconnu';
    }
  }

}
