import 'package:bloc_learning/data/token_repository.dart';
import 'package:dio/dio.dart';

class HeadersIncerceptor extends Interceptor {
  HeadersIncerceptor({required this.tokenRepository});

  final TokenRepository tokenRepository;
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenRepository.readToken();

    options.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    return super.onRequest(options, handler);
  }
}
