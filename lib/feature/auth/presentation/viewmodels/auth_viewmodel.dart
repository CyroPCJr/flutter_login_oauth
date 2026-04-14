import 'package:flutter/foundation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/login_with_google.dart';
import '../../domain/usecases/logout.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthViewModel extends ChangeNotifier {
  final LoginWithEmail loginWithEmailUseCase;
  final LoginWithGoogle loginWithGoogleUseCase;
  final GetCurrentUser getCurrentUserUseCase;
  final Logout logoutUseCase;

  AuthViewModel({
    required this.loginWithEmailUseCase,
    required this.loginWithGoogleUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  });

  AuthStatus _status = AuthStatus.initial;
  UserEntity? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  UserEntity? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<void> checkAuth() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      _user = await getCurrentUserUseCase();
      _status = _user == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> loginWithEmail(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await loginWithEmailUseCase(email: email, password: password);
      _status = AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await loginWithGoogleUseCase();
      _status = AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> logout() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      await logoutUseCase();
      _user = null;
      _status = AuthStatus.unauthenticated;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }
}
