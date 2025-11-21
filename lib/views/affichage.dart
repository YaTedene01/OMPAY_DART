import 'dart:io';
import 'package:ompay_dart/core/injection_dependance.dart';
import 'package:ompay_dart/services/AuthService.dart';
import 'package:ompay_dart/services/CompteService.dart';
import 'package:ompay_dart/models/user.dart';
import 'package:ompay_dart/models/compte.dart';
import 'package:ompay_dart/models/transaction.dart';

class Affichage {
  final AuthService _authService = getIt<AuthService>();
  final CompteService _compteService = getIt<CompteService>();

  void run(List<String> arguments) {
    if (arguments.isEmpty) {
      _showHelp();
      return;
    }

    final command = arguments[0];
    final args = arguments.sublist(1);

    switch (command) {
      case 'auth':
        _handleAuth(args);
        break;
      case 'dashboard':
        _handleDashboard();
        break;
      case 'transfer':
        _handleTransfer(args);
        break;
      case 'paiement':
        _handlePay(args);
        break;
      case 'transactions':
        _handleTransactions(args);
        break;
      case 'solde':
        _handleBalance();
        break;
      case 'deconnexion':
        _handleLogout();
        break;
      case 'help':
      default:
        _showHelp();
    }
  }

  void _showHelp() {
    print('OMPAY - application de transfert et de paiement');
    print('');
    print('Usage: dart run bin/ompay_dart.dart <command> [arguments]');
    print('');
    print('Commands:');
    print(' 1- auth <phone>           Envoyer un lien d\'authentification');
    print(' 2- auth echange <token>   Échanger un token temporaire');
    print(' 3- dashboard              Afficher le tableau de bord');
    print(' 4- transfer <phone> <montant>  Transférer de l\'argent');
    print(' 5- paiement <code> <montant>   Payer avec un code marchand');
    print(' 6- transactions [type]    Lister les transactions');
    print(' 7- solde                  Consulter le solde');
    print(' 8- deconnexion            Se déconnecter');
    print(' 9- help                   Afficher cette aide');
    print('');
    print('Examples:');
    print('  dart run bin/ompay_dart.dart auth 771234567');
    print('  dart run bin/ompay_dart.dart auth echange abc123...');
    print('  dart run bin/ompay_dart.dart transfer 771234567 50.0');
  }

  void _handleAuth(List<String> args) {
    if (args.isEmpty) {
      print('Erreur: numéro de téléphone requis');
      print('Usage: auth <phone>');
      return;
    }

    if (args.length == 2 && args[0] == 'echange') {
      final token = args[1];
      _exchangeToken(token);
      return;
    }

    final phone = args[0];
    _sendAuthLink(phone);
  }

  void _sendAuthLink(String phone) async {
    try {
      print('Envoi du lien d\'authentification à $phone...');
      final response = await _authService.sendAuthLink(phone);
      print('✅ ${response.message}');
      print('Token: ${response.token}');
      print('Expire dans: ${response.expiresIn} secondes');
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _exchangeToken(String token) async {
    try {
      print('Échange du token...');
      final response = await _authService.exchangeToken(token);
      print('✅ Authentification réussie');
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _handleDashboard() async {
    try {
      print('Récupération du tableau de bord...');
      final dashboard = await _compteService.getDashboard();

      print('');
      print('=== TABLEAU DE BORD ===');
      print('Utilisateur: ${dashboard.user.name ?? 'N/A'} (${dashboard.user.phone})');
      print('Solde: ${dashboard.compte.solde} ${dashboard.compte.devise}');
      print('QR Code: ${dashboard.qrCode.code}');
      print('');
      if (dashboard.recentTransactions.isNotEmpty) {
        print('Transactions récentes:');
        for (final transaction in dashboard.recentTransactions) {
          print('  ${transaction.type}: ${transaction.montant} ${dashboard.compte.devise} - ${transaction.status}');
        }
      } else {
        print('Aucune transaction récente');
      }
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _handleTransfer(List<String> args) {
    if (args.length < 2) {
      print('Erreur: téléphone et montant requis');
      print('Usage: transfer <phone> <montant>');
      return;
    }

    final phone = args[0];
    final amount = double.tryParse(args[1]);

    if (amount == null) {
      print('Erreur: montant invalide');
      return;
    }

    _transfer(phone, amount);
  }

  void _transfer(String phone, double amount) async {
    try {
      print('Transfert de $amount vers $phone...');
      final response = await _compteService.transfer(toPhone: phone, montant: amount);
      print('✅ Transfert effectué');
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _handlePay(List<String> args) {
    if (args.length < 2) {
      print('Erreur: code marchand et montant requis');
      print('Usage: paiement <code> <montant>');
      return;
    }

    final code = args[0];
    final amount = double.tryParse(args[1]);

    if (amount == null) {
      print('Erreur: montant invalide');
      return;
    }

    _pay(code, amount);
  }

  void _pay(String code, double amount) async {
    try {
      print('Paiement de $amount avec le code $code...');
      final response = await _compteService.paiement(code, amount);
      print('✅ Paiement effectué');
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  Future<void> _handleTransactions(List<String> args) async {
    final type = args.isNotEmpty ? args[0] : null;

    try {
      print('Récupération des transactions...');
      final response = await _compteService.getTransactions(type: type);

      print('');
      print('=== TRANSACTIONS ===');
      if (response.data.isNotEmpty) {
        for (final transaction in response.data) {
          final cleanType = _cleanTransactionType(transaction.type);
          final recipient = await _getRecipientInfo(transaction);
          print('${transaction.id}: ${transaction.createdAt}: $cleanType - ${transaction.montant} XOF - $recipient');
        }
      } else {
        print('Aucune transaction trouvée');
      }
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _handleBalance() async {
    try {
      print('Récupération du solde...');
      final response = await _compteService.getSolde();

      print('Solde: ${response.solde} ${response.devise}');
      print('Dernière mise à jour: ${response.dernierMaj}');
    } catch (e) {
      print('❌ Erreur: $e');
    }
  }

  void _handleLogout() async {
    try {
      print('Déconnexion...');
      final response = await _authService.logout();
      print('✅ ${response.message}');
    } catch (e) {
      print('❌ Erreur lors de la déconnexion: $e');
      print('✅ Token local nettoyé');
    }
  }

  String _cleanTransactionType(String type) {
    if (type.endsWith('_debit')) {
      return type.replaceAll('_debit', '');
    }
    return type;
  }

  Future<String> _getRecipientInfo(Transaction transaction) async {
    if (transaction.type.startsWith('paiement') && transaction.metadata != null) {
      final meta = transaction.metadata!;
      if (meta.containsKey('code_marchand')) {
        return meta['code_marchand'].toString();
      }
    }

    if (transaction.type.startsWith('transfert') && transaction.counterparty != null) {
      try {
        return await _compteService.getUserInfoByAccountId(transaction.counterparty!);
      } catch (e) {
        return transaction.counterparty!;
      }
    }

    return transaction.counterparty ?? 'N/A';
  }

}
