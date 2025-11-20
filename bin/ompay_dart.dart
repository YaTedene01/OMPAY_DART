import 'package:ompay_dart/core/injection_dependance.dart';
import 'package:ompay_dart/views/affichage.dart';

void main(List<String> arguments) {
  
  const baseUrl = 'https://ompay-wex1.onrender.com';
  setupDependencies(baseUrl);

    final affichage = Affichage();
    affichage.run(arguments);
}
