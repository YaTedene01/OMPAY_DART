import 'package:get_it/get_it.dart';
import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/services/AuthService.dart';
import 'package:ompay_dart/services/CompteService.dart';

final getIt = GetIt.instance;

void setupDependencies(String baseUrl) {
  getIt.registerSingleton<ApiService>(ApiService(baseUrl: baseUrl));

  getIt.registerSingleton<AuthService>(AuthService(getIt<ApiService>()));
  getIt.registerSingleton<CompteService>(CompteService(getIt<ApiService>()));
}