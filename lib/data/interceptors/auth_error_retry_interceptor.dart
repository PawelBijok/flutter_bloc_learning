import 'package:bloc_learning/data/interceptors/dio_request_retrier.dart';
import 'package:bloc_learning/data/services/token_service.dart';
import 'package:bloc_learning/data/token_repository.dart';
import 'package:dio/dio.dart';

class AuthErrorRetryInterceptor extends Interceptor {
  AuthErrorRetryInterceptor({required this.tokenRepository, required this.tokenService, required this.requestRetrier});

  final TokenRepository tokenRepository;
  final DioRequestRetrier requestRetrier;
  final TokenService tokenService;
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRequestNewTokenAndRetry(err)) {
      final newToken = await tokenService.requestNewToken();
      await tokenRepository.saveToken(newToken);
      try {
        final retryData = await requestRetrier.retry(err.requestOptions);

        return handler.resolve(retryData);
      } catch (_) {
        return handler.reject(err);
      }
    }

    return handler.reject(err);
  }

  bool _shouldRequestNewTokenAndRetry(DioError err) {
    if (err.response == null || err.type != DioErrorType.response) {
      return false;
    }
    if (err.response!.statusCode == 400 || err.response!.statusCode == 401) {
      return true;
    }

    return false;
  }
}
