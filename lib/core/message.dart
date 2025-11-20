import 'dart:async';
import 'dart:io';

class Message {
    
  static const String unknownError = "Une erreur inconnue est survenue.";
  static const String networkError = "Erreur réseau. Vérifiez votre connexion.";
  static const String timeout = "Délai d'attente dépassé. Réessayez.";
  static const String parsingError = "Erreur lors du traitement de la réponse.";
  static const String noInternet = "Aucune connexion Internet.";
  static const String validationError = "Données invalides.";
  static const String unauthorized = "Accès non autorisé.";
  static const String forbidden = "Action interdite.";
  static const String notFound = "Ressource introuvable.";
  static const String badRequest = "Requête invalide.";
  static const String internalServerError = "Erreur interne du serveur.";
  static const String success = "Succès.";
  static const String created = "Créé avec succès.";

  static String fromStatusCode(int code) {
    switch (code) {
      case 200:
        return success;
      case 201:
        return created;
      case 400:
        return badRequest;
      case 401:
        return unauthorized;
      case 403:
        return forbidden;
      case 404:
        return notFound;
      case 422:
        return validationError;
      case 500:
        return internalServerError;
      default:
        return unknownError;
    }
  }

  static String fromException(Object error) {
    if (error is TimeoutException) return timeout;
    if (error is SocketException) return noInternet;
    return networkError;
  }
}