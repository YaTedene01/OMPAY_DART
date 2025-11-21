import 'dart:io';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:get_it/get_it.dart';
import 'package:ompay_dart/core/api_service.dart';
import 'package:ompay_dart/services/AuthService.dart';
import 'package:ompay_dart/services/CompteService.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final env = dotenv.DotEnv(includePlatformEnvironment: true)..load(['.env']);

  final baseUrl = env['API_BASE_URL'] ?? 'https://ompay-wex1.onrender.com';

  getIt.registerSingleton<ApiService>(ApiService(baseUrl: baseUrl));

  getIt.registerSingleton<AuthService>(AuthService(getIt<ApiService>()));
  getIt.registerSingleton<CompteService>(CompteService(getIt<ApiService>()));
}