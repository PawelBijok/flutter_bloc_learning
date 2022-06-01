// ignore_for_file: avoid_returning_null_for_void

import 'package:bloc_learning/data/interceptors/auth_error_retry_interceptor.dart';
import 'package:bloc_learning/data/interceptors/dio_request_retrier.dart';
import 'package:bloc_learning/data/repositories/token_repository.dart';
import 'package:bloc_learning/data/services/token_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTokenRepository extends Mock implements TokenRepository {}

class MockTokenService extends Mock implements TokenService {}

class MockRequestRetryier extends Mock implements DioRequestRetrier {}

class MockResponse extends Mock implements Response {}

void main() {
  late AuthErrorRetryInterceptor authErrorInterceptor;
  late MockTokenRepository mockTokenRepository;
  late MockTokenService mockTokenService;
  late MockRequestRetryier mockRequestRetryier;

  final requestOptions = RequestOptions(path: '/');

  setUp(() {
    mockTokenRepository = MockTokenRepository();
    mockTokenService = MockTokenService();
    mockRequestRetryier = MockRequestRetryier();
    authErrorInterceptor = AuthErrorRetryInterceptor(
      requestRetrier: mockRequestRetryier,
      tokenRepository: mockTokenRepository,
      tokenService: mockTokenService,
    );
  });

  group('AuthErrorRetryInterceptor', () {
    test(
      'requests new token on error and saves it',
      () async {
        final dioError = DioError(requestOptions: requestOptions);
        dioError.type = DioErrorType.response;
        dioError.response = Response(requestOptions: requestOptions, statusCode: 401);
        when(() => mockTokenService.requestNewToken()).thenAnswer((_) async => '123');
        when(() => mockTokenRepository.saveToken('123')).thenAnswer((_) async => null);
        when(() => mockRequestRetryier.retry(dioError.requestOptions)).thenAnswer((_) async => MockResponse());
        await authErrorInterceptor.onError(dioError, ErrorInterceptorHandler());

        verify(() => mockTokenService.requestNewToken()).called(1);
        verify(() => mockTokenRepository.saveToken('123')).called(1);
      },
    );
  });
}
