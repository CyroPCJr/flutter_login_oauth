import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });
  Future<UserEntity> loginWithGoogle();
  Future<void> logout();
}
