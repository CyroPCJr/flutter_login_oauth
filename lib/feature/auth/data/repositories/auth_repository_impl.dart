import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<UserEntity?> getCurrentUser() => remote.getCurrentUser();

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final user = await remote.loginWithEmail(email: email, password: password);
    await local.saveLoginMeta(provider: 'email', email: email);
    return user;
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final user = await remote.loginWithGoogle();
    await local.saveLoginMeta(provider: 'google', email: user.email);
    return user;
  }

  @override
  Future<void> logout() async {
    await remote.logout();
    await local.clear();
  }
}
