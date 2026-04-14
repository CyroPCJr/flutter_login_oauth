import 'package:fluttter_login_oauth/core/services/secure_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveLoginMeta({required String provider, String? email});
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveLoginMeta({required String provider, String? email}) async {
    await storage.saveProvider(provider);
    if (email != null && email.isNotEmpty) {
      await storage.saveLastEmail(email);
    }
  }

  @override
  Future<void> clear() async {
    await storage.clear();
  }
}
