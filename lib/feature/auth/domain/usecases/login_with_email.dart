import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  Future<UserEntity> call({required String email, required String password}) {
    return repository.loginWithEmail(email: email, password: password);
  }
}
