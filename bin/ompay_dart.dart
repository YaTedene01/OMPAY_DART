import 'package:ompay_dart/core/injection_dependance.dart';
import 'package:ompay_dart/views/affichage.dart';

void main(List<String> arguments) async {
  await setupDependencies();

  final affichage = Affichage();
  affichage.run(arguments);
}
