import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  const SecureStorageService(this._storage);

  static const _providerKey = 'auth_provider';
  static const _lastEmailKey = 'last_email';

  Future<void> saveProvider(String provider) async {
    await _storage.write(key: _providerKey, value: provider);
  }

  Future<void> saveLastEmail(String email) async {
    await _storage.write(key: _lastEmailKey, value: email);
  }

  Future<String?> readProvider() async {
    return _storage.read(key: _providerKey);
  }

  Future<String?> readLastEmail() async {
    return _storage.read(key: _lastEmailKey);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
