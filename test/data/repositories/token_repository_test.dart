// ignore_for_file: avoid_returning_null_for_void

import 'package:bloc_learning/data/repositories/token_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late TokenRepository sut;
  late MockSecureStorage mockSecureStorage;
  const String fakeToken = 'fake-access-token';
  const String fakeToken2 = 'fake-access-token-123123';

  setUp(() {
    mockSecureStorage = MockSecureStorage();
    sut = TokenRepositoryImplementation(secureStorage: mockSecureStorage);
  });

  group('Token repository', () {
    test(
      'return token from secure storage when readToken is ran',
      () async {
        when(() => mockSecureStorage.read(key: any(named: 'key'))).thenAnswer((_) async => fakeToken);
        final token = await sut.readToken();
        expect(token, fakeToken);
      },
    );
    test(
      'return null when readToken is ran but no entry in secure storage exists',
      () async {
        when(() => mockSecureStorage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
        final token = await sut.readToken();
        expect(token, null);
      },
    );
    test(
      'saves token to secure storage when saveToken is ran',
      () async {
        when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
            .thenAnswer((_) async => null);
        await sut.saveToken(fakeToken2);
        verify(
          () => mockSecureStorage.write(key: any(named: 'key'), value: fakeToken2),
        ).called(1);
      },
    );
  });
}
