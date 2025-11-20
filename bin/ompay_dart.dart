import 'package:ompay_dart/core/injection_dependance.dart';
import 'package:ompay_dart/views/affichage.dart';

void main(List<String> arguments) {
  // Initialize dependencies with the backend URL
  // You can change this to your actual backend URL
  const baseUrl = 'https://ompay-wex1.onrender.com';
  setupDependencies(baseUrl);

  // Run the CLI
    final affichage = Affichage();
    affichage.run(arguments);
}
