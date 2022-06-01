import 'package:bloc_learning/data/interceptors/headers_incerceptor.dart';
import 'package:bloc_learning/data/repositories/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenRepository extends Mock implements TokenRepository {}

void main() {
  late HeadersIncerceptor headersIncerceptor;
  late MockTokenRepository mockTokenRepository;
  setUp(() {
    mockTokenRepository = MockTokenRepository();
    headersIncerceptor = HeadersIncerceptor(tokenRepository: mockTokenRepository);
  });

  group('HeadersInterceptor', () {
    test(
      'adds headers to request',
      () async {
        final RequestOptions reqOptions = RequestOptions(path: '/');
        when(() => mockTokenRepository.readToken()).thenAnswer((_) async => '123');
        await headersIncerceptor.onRequest(reqOptions, RequestInterceptorHandler());

        expect(reqOptions.headers['Authorization'], 'Bearer 123');
        expect(reqOptions.headers['Content-Type'], 'application/json');
      },
    );
  });
}
