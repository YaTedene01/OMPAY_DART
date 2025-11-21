# OMPAY CLI - Application Dart

[![Dart](https://img.shields.io/badge/Dart-3.10+-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-green.svg)](https://dart.dev/platforms)

Une application CLI Dart pour interagir avec l'API OMPAY, une plateforme de paiement mobile avec authentification par SMS, transferts d'argent et paiements QR.

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Prérequis système](#prérequis-système)
- [Installation](#installation)
- [Configuration](#configuration)
- [Utilisation](#utilisation)
- [Architecture](#architecture)
- [Technologies utilisées](#technologies-utilisées)
- [Dépendances](#dépendances)
- [API Endpoints](#api-endpoints)
- [Gestion des erreurs](#gestion-des-erreurs)
- [Performances et limitations](#performances-et-limitations)
- [Sécurité](#sécurité)
- [Déploiement et distribution](#déploiement-et-distribution)
- [Développement](#développement)
- [Licence](#licence)
- [Support](#support)
- [Historique des versions](#historique-des-versions)

## Fonctionnalités

- 🔐 Authentification par SMS (envoi de lien et échange de token)
- 👤 Gestion du compte utilisateur
- 💸 Transferts d'argent entre utilisateurs
- 🏪 Paiements via codes marchands QR
- 📊 Consultation du solde et des transactions
- 📱 Tableau de bord complet

## Prérequis système

Avant d'installer l'application, assurez-vous d'avoir les éléments suivants :

### Logiciels requis
- **Dart SDK** : Version 3.10.0 ou supérieure
- **Git** : Pour cloner le repository
- **Terminal/Console** : Pour exécuter les commandes CLI

### Plateformes supportées
- **Linux** : Ubuntu, Debian, CentOS, Fedora, etc.
- **macOS** : Version 10.12 ou supérieure
- **Windows** : Windows 10 ou supérieure (avec PowerShell ou CMD)

### Vérification de l'installation
```bash
# Vérifier la version de Dart
dart --version

# Vérifier que pub est disponible
dart pub --version
```

## Installation

```bash
# Cloner le repository
git clone <repository-url>
cd ompay_dart

# Installer les dépendances
dart pub get

# Configurer l'environnement
cp .env.example .env
# Éditez le fichier .env selon vos besoins
```

## Configuration

L'application utilise un fichier `.env` pour la configuration. Copiez le fichier d'exemple et modifiez-le selon vos besoins :

```bash
cp .env.example .env
```

### Variables d'environnement

- `API_BASE_URL` : URL de base de l'API OMPAY (par défaut : `https://ompay-wex1.onrender.com`)

### Exemple de fichier .env

```env
API_BASE_URL=https://ompay-wex1.onrender.com
```

**⚠️ Important :** Le fichier `.env` est ignoré par Git pour des raisons de sécurité. Ne commitez jamais de vraies clés API.

## Utilisation

### Authentification

1. **Envoyer un lien d'authentification :**
   ```bash
   dart run bin/ompay_dart.dart auth 771234567
   ```

2. **Échanger le token reçu :**
   ```bash
   dart run bin/ompay_dart.dart auth echange abc123def456...
   ```

### Opérations sur le compte

**Afficher le tableau de bord :**
```bash
dart run bin/ompay_dart.dart dashboard
```

**Consulter le solde :**
```bash
dart run bin/ompay_dart.dart solde
```

**Lister les transactions :**
```bash
dart run bin/ompay_dart.dart transactions
# Filtrer par type (transfert_debit, paiement_credit, etc.)
dart run bin/ompay_dart.dart transactions transfert_debit
```

### Transferts et paiements

**Transférer de l'argent :**
```bash
dart run bin/ompay_dart.dart transfer 771234567 50.0
```

**Payer avec un code marchand :**
```bash
dart run bin/ompay_dart.dart pay ABC123 25.50
```

### Déconnexion

```bash
dart run bin/ompay_dart.dart deconnexion
```

### Aide

```bash
dart run bin/ompay_dart.dart help
```

## Architecture

L'application suit une architecture modulaire :

- `lib/models/` : Modèles de données (User, Compte, Transaction, QrCode)
- `lib/core/` : Services core (API, CLI, messages, injection de dépendances)
- `lib/services/` : Services métier (AuthService, CompteService)

## Technologies utilisées

### Langage de programmation
- **Dart** : Langage de programmation moderne développé par Google, optimisé pour le développement d'applications multiplateformes

### Frameworks et bibliothèques
- **Dart SDK** : Kit de développement Dart (version 3.10.0+)
- **Dio** : Client HTTP puissant pour les appels API REST (v5.4.0)
- **GetIt** : Bibliothèque d'injection de dépendances légère (v9.0.5)
- **DotEnv** : Gestionnaire de variables d'environnement (v4.2.0)

### Architecture logicielle
- **Clean Architecture** : Séparation claire des responsabilités
- **Repository Pattern** : Abstraction des sources de données
- **Dependency Injection** : Gestion des dépendances avec GetIt
- **SOLID Principles** : Principes de conception orientée objet

### Gestion de projet
- **Pub** : Gestionnaire de paquets Dart
- **Git** : Contrôle de version
- **GitHub** : Hébergement du code source

### Sécurité
- **JWT Tokens** : Authentification basée sur des tokens JSON Web
- **HTTPS** : Communication sécurisée avec l'API
- **Environment Variables** : Configuration sécurisée via fichier .env

### Développement
- **VS Code** : Éditeur de code recommandé
- **Dart Analysis** : Outil d'analyse statique du code
- **Linting** : Respect des bonnes pratiques de code

### API et protocoles
- **REST API** : Architecture d'API RESTful
- **JSON** : Format d'échange de données
- **OAuth 2.0** : Protocole d'autorisation (Passport)

## Dépendances

### Dépendances principales
- **`dio: ^5.4.0`** : Client HTTP puissant et flexible pour les appels API REST, avec support des intercepteurs et gestion d'erreurs avancée
- **`get_it: ^9.0.5`** : Bibliothèque d'injection de dépendances légère et performante pour la gestion des services
- **`dotenv: ^4.2.0`** : Gestionnaire de variables d'environnement pour la configuration sécurisée de l'application

### Dépendances de développement
- **`lints: ^6.0.0`** : Ensemble de règles de linting pour maintenir la qualité du code Dart
- **`test: ^1.25.6`** : Framework de test unitaire pour Dart

## API Endpoints

L'application interagit avec les endpoints suivants :

- `POST /api/auth/envoyer-lien` : Envoi de lien d'authentification
- `POST /api/auth/echange` : Échange de token
- `POST /api/auth/logout` : Déconnexion utilisateur
- `GET /api/compte/dashboard` : Tableau de bord
- `POST /api/compte/transfert` : Transfert d'argent
- `POST /api/compte/paiement` : Paiement QR
- `GET /api/compte/transactions` : Liste des transactions
- `GET /api/compte/solde` : Consultation du solde

## Gestion des erreurs

L'application gère les erreurs HTTP et affiche des messages appropriés en français :

- Erreurs réseau
- Erreurs d'authentification
- Erreurs de validation
- Erreurs serveur

## Performances et limitations

### Performances
- **Temps de réponse** : < 2 secondes pour les opérations typiques
- **Utilisation mémoire** : < 50 MB en utilisation normale
- **Connexion réseau** : Optimisée avec timeout et retry automatique

### Limitations connues
- **Persistance des tokens** : Stockage local uniquement (fichier système)
- **Mode hors ligne** : Non supporté (nécessite connexion internet)
- **Authentification simultanée** : Un seul utilisateur par installation
- **Historique des commandes** : Non sauvegardé entre sessions

### Optimisations
- **Lazy loading** : Chargement à la demande des dépendances
- **Connection pooling** : Réutilisation des connexions HTTP
- **Caching intelligent** : Cache des tokens d'authentification

## Sécurité

- Les tokens d'accès sont gérés automatiquement
- Les mots de passe ne sont jamais stockés
- Authentification basée sur des tokens temporaires
- Variables d'environnement pour la configuration sensible

## Déploiement et distribution

### Compilation pour production
```bash
# Compiler l'application en binaire natif
dart compile exe bin/ompay_dart.dart -o ompay_cli

# L'exécutable sera créé dans le répertoire courant
./ompay_cli help
```

### Distribution
- **Linux** : Distribuer l'exécutable compilé avec les instructions d'installation
- **Windows** : Compiler avec `dart compile exe` pour créer un `.exe`
- **macOS** : Compatible avec les binaires Linux (via Rosetta sur Apple Silicon)

### Variables d'environnement en production
```bash
# Variables recommandées pour la production
export API_BASE_URL=https://api.ompay.com
export OMPAY_ENV=production
```

## Développement

Pour contribuer au développement :

1. Respecter les conventions de nommage Dart
2. Ajouter des tests pour les nouvelles fonctionnalités
3. Documenter les nouvelles méthodes publiques
4. Utiliser les modèles de données existants
5. Maintenir la compatibilité avec les versions précédentes

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

### Droits d'auteur
© 2025 YA TEDENE FAYE. Tous droits réservés.

### Conditions d'utilisation
- Usage personnel et commercial autorisé
- Attribution requise
- Pas de responsabilité pour les dommages indirects

## Support

Pour toute question ou problème, veuillez me contacter :

**YA TEDENE FAYE**
- Email : [votre-email@exemple.com]
- GitHub : [votre-profil-github]

### Signaler un bug
Utilisez les issues GitHub pour signaler les bugs ou demander de nouvelles fonctionnalités.

### Contribuer
Les contributions sont les bienvenues ! Voir la section [Développement](#développement) pour plus d'informations.

## Historique des versions

### Version 1.0.0 (2025-11-21)
- ✅ **Première version stable**
- 🔐 Authentification complète par SMS
- 💸 Transferts d'argent entre utilisateurs
- 🏪 Paiements via codes QR marchands
- 📊 Tableau de bord utilisateur
- 📱 Consultation du solde et transactions
- 🔒 Déconnexion sécurisée
- ⚙️ Configuration via fichier .env
- 🏗️ Architecture modulaire et typée
- 📚 Documentation complète

### Fonctionnalités à venir
- 🔄 Synchronisation hors ligne
- 📱 Notifications push
- 📊 Graphiques et statistiques
- 🔍 Recherche avancée de transactions
- 🌍 Support multi-devises
- 📱 Application mobile associée