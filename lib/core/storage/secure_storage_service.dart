import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String fakeToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXe';

  Future<void> saveToken(String token) async {
    await _storage.write(
      key: fakeToken,
      value: token,
    );
  }

  Future<String?> readToken() async {
    return _storage.read(key: fakeToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: fakeToken);
  }
}
