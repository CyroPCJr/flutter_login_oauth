# Flutter Login OAuth

A modern Flutter authentication application featuring Google OAuth 2.0 and Firebase Authentication, built with clean architecture principles and best practices for state management and secure credential storage.

## 📋 Project Overview

**Flutter Login OAuth** is a production-ready authentication system that demonstrates:
- Firebase Authentication integration
- Google OAuth 2.0 sign-in
- Email/password authentication
- Secure token storage
- Clean Architecture pattern
- Dependency injection
- State management with Provider pattern
- Cross-platform support (Android, iOS)

## 🎯 Features

### Authentication
- ✅ **Google Sign-In** - OAuth 2.0 authentication with Google
- ✅ **Email/Password Login** - Traditional email-based authentication via Firebase
- ✅ **Session Persistence** - Secure storage of authentication tokens
- ✅ **Auto-Login** - Automatic authentication on app launch if session exists
- ✅ **Logout** - Complete session termination and secure storage cleanup

### User Experience
- 🎨 **Material Design 3** - Modern UI with Material Design principles
- 📱 **Responsive UI** - Optimized for various screen sizes
- ⚡ **Splash Screen** - App initialization with authentication state check
- 🔄 **State Management** - Reactive state updates using Provider pattern

### Security
- 🔐 **Secure Storage** - Encrypted credential storage using `flutter_secure_storage`
- 🛡️ **Firebase Security** - Server-side authentication validation
- 🔑 **Token Management** - Secure handling of authentication tokens

## 🏗️ Architecture

The project follows **Clean Architecture** with three main layers:

```
lib/
├── feature/
│   └── auth/
│       ├── data/                    # Data layer (DTOs, DataSources, Repositories)
│       │   ├── datasources/
│       │   │   ├── auth_remote_datasource.dart    # Firebase API calls
│       │   │   └── auth_local_datasource.dart     # Secure storage operations
│       │   └── repositories/
│       │       └── auth_repository_impl.dart      # Repository implementation
│       ├── domain/                  # Domain layer (Business Logic)
│       │   ├── repositories/
│       │   │   └── auth_repository.dart           # Repository interface
│       │   └── usecases/
│       │       ├── login_with_email.dart
│       │       ├── login_with_google.dart
│       │       ├── get_current_user.dart
│       │       └── logout.dart
│       └── presentation/            # Presentation layer (UI)
│           ├── pages/
│           │   ├── splash_page.dart               # App initialization
│           │   ├── login_page.dart                # Authentication screen
│           │   └── home_page.dart                 # Post-auth home screen
│           ├── viewmodels/
│           │   └── auth_viewmodel.dart            # State management
│           └── widgets/
│               └── [Custom UI components]
├── core/                            # Shared utilities
│   ├── error/                       # Error handling
│   ├── services/
│   │   └── secure_storage_service.dart
│   └── utils/
├── firebase_options.dart            # Firebase configuration
├── injection_container.dart         # Dependency injection setup
└── main.dart                        # App entry point
```

## 🔧 Technical Stack

| Component | Package | Version |
|-----------|---------|---------|
| **Framework** | Flutter | - |
| **Language** | Dart | ^3.11.4 |
| **Authentication** | firebase_auth | ^6.4.0 |
| **Firebase Core** | firebase_core | ^4.7.0 |
| **OAuth Provider** | google_sign_in | ^7.2.0 |
| **Secure Storage** | flutter_secure_storage | ^10.0.0 |
| **State Management** | provider | ^6.1.5+1 |
| **Dependency Injection** | get_it | ^9.2.1 |
| **UI Design** | Material Design 3 | Built-in |

## 📦 Dependencies

### Production Dependencies
```yaml
firebase_core: ^4.7.0           # Firebase initialization
firebase_auth: ^6.4.0           # Firebase Authentication
google_sign_in: ^7.2.0          # Google OAuth 2.0
flutter_secure_storage: ^10.0.0 # Encrypted local storage
provider: ^6.1.5+1              # State management
get_it: ^9.2.1                  # Service locator
cupertino_icons: ^1.0.9         # Icon assets
```

### Development Dependencies
```yaml
flutter_test: [SDK]             # Flutter testing framework
flutter_lints: ^6.0.0           # Dart linting
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: ^3.11.4
- Android SDK (for Android development)
- Xcode (for iOS development)
- Firebase project with authentication enabled
- Google OAuth credentials

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_login_oauth
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [firebase.google.com](https://firebase.google.com)
   - Enable Email/Password and Google authentication methods
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place `google-services.json` in `android/app/`

4. **Regenerate Firebase Configuration**
   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure Firebase for your project
   flutterfire configure
   ```
   This will automatically generate/update `firebase_options.dart` and `google-services.json`

5. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Platforms Supported

- ✅ **Android** - API 21+
- ✅ **iOS** - iOS 13.0+
- ❌ **Web** - Not currently configured (can be added via FlutterFire)
- ❌ **macOS** - Not currently configured
- ❌ **Windows** - Not currently configured
- ❌ **Linux** - Not currently configured

## 🔐 Security Considerations

### Environment Variables & Secrets
⚠️ **NEVER commit sensitive credentials to version control:**
- `google-services.json` - Android Firebase configuration
- `firebase_options.dart` - Firebase API keys
- `.env` files - Environment-specific credentials

These files should be:
1. Added to `.gitignore`
2. Managed separately (CI/CD secrets, secure environment variables)
3. Regenerated for each environment (dev, staging, production)

**If credentials are exposed:**
1. Immediately disable them in Firebase Console
2. Regenerate new credentials via FlutterFire CLI
3. Force-push to remove from git history
4. Rotate API keys in production

### Best Practices Implemented
- ✅ Secure storage for tokens using encrypted storage
- ✅ Session validation on app startup
- ✅ Proper error handling and user feedback
- ✅ Dependency injection for testability
- ✅ Clean separation of concerns

## 📖 Usage

### Authentication Flow

1. **App Launch**
   - SplashPage checks for existing session
   - If authenticated, navigate to HomePage
   - If not, navigate to LoginPage

2. **Login with Email**
   - User enters email and password
   - Firebase validates credentials
   - On success, token is stored securely
   - Navigate to HomePage

3. **Login with Google**
   - User initiates Google Sign-In
   - Google authentication popup appears
   - On success, Firebase creates/links account
   - Token is stored securely
   - Navigate to HomePage

4. **Logout**
   - User initiates logout
   - Session is cleared from secure storage
   - Firebase session is terminated
   - Navigate back to LoginPage

## 🧪 Testing

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate coverage report
lcov --list coverage/lcov.info
```

## 📱 Project Structure Details

### Data Layer (`lib/feature/auth/data/`)
Handles Firebase API calls and local storage:
- **AuthRemoteDataSource**: Firebase Authentication operations
- **AuthLocalDataSource**: Secure token persistence
- **AuthRepositoryImpl**: Combines local and remote data sources

### Domain Layer (`lib/feature/auth/domain/`)
Business logic and use cases:
- **AuthRepository**: Interface for authentication operations
- **UseCases**: 
  - `LoginWithEmail`: Email-based authentication
  - `LoginWithGoogle`: OAuth 2.0 sign-in
  - `GetCurrentUser`: Retrieve authenticated user
  - `Logout`: Terminate session

### Presentation Layer (`lib/feature/auth/presentation/`)
UI and state management:
- **SplashPage**: App initialization and auth check
- **LoginPage**: User authentication interface
- **HomePage**: Authenticated user dashboard
- **AuthViewModel**: Manages authentication state using ChangeNotifier

### Core Layer (`lib/core/`)
Shared utilities and services:
- **SecureStorageService**: Wrapper for encrypted credential storage
- **Error Handling**: Custom exceptions and error models
- **Utils**: Reusable helper functions

## 🐛 Troubleshooting

### Firebase Configuration Issues
```bash
# Verify Firebase setup
flutter doctor -v

# Reconfigure Firebase
flutterfire configure --overwrite
```

### Google Sign-In Issues
- Ensure SHA-1 fingerprint is registered in Firebase Console
- Verify Google OAuth credentials in Google Cloud Console
- Check AndroidManifest.xml has correct package name

### Secure Storage Issues
- On Android 5.0+: Uses Android Keystore
- On iOS: Uses Keychain
- Clear app data if storage becomes corrupted

### Build Issues
```bash
# Clean build
flutter clean
flutter pub get
flutter run

# Check dependencies
flutter pub outdated
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes following conventional commits
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Code Style

This project follows:
- **Dart Style Guide** (enforced by `flutter_lints`)
- **Flutter Best Practices**
- **Clean Code Principles**

Run linter:
```bash
flutter analyze
```

Fix linting issues:
```bash
dart fix --apply
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Project Name**: Flutter Login OAuth  
**Platform**: Cross-platform (Android, iOS)  
**Version**: 0.1.0+1

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase for Flutter](https://firebase.flutter.dev/)
- [Google Sign-In for Flutter](https://pub.dev/packages/google_sign_in)
- [Clean Architecture in Flutter](https://medium.com/flutter-community/clean-architecture-in-flutter)
- [Provider State Management](https://pub.dev/packages/provider)

## 🔄 Version History

### v0.1.0 (Current)
- Initial project setup
- Firebase Authentication integration
- Google OAuth 2.0 implementation
- Email/Password login
- Secure token storage
- Clean Architecture implementation
