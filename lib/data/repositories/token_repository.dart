import 'package:bloc_learning/resources/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenRepository {
  Future<void> saveToken(String token);
  Future<String?> readToken();
}

class TokenRepositoryImplementation implements TokenRepository {
  TokenRepositoryImplementation({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: Constants.secureStorageApiTokenKey, value: token);
  }

  @override
  Future<String?> readToken() async {
    return secureStorage.read(key: Constants.secureStorageApiTokenKey);
  }
}
