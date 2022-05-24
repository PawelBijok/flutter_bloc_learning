import 'package:dio/dio.dart';

class DioRequestRetrier {
  DioRequestRetrier({
    required this.dio,
  });

  final Dio dio;

  Future<Response> retry(RequestOptions requestOptions) async {
    return dio.request(
      '${requestOptions.baseUrl}${requestOptions.path}',
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        contentType: requestOptions.contentType,
        headers: requestOptions.headers,
      ),
    );
  }
}
