import 'dart:convert';

import 'package:bloc_learning/resources/constants.dart';
import 'package:bloc_learning/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class TokenService {
  TokenService({required this.dio});

  final Dio dio;
  final _logger = getIt<Logger>();
  Future<String> requestNewToken() async {
    _logger.v('requesting new token');

    final authStringBuffer = _createAuthStringBuffer();

    dio.options.headers = {
      'Authorization': 'Basic $authStringBuffer',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    dio.options.queryParameters = {'grant_type': 'client_credentials'};

    final response = await dio.post(
      Constants.spotifyAuthUrl,
    );

    return response.data['access_token'];
  }

  String _createAuthStringBuffer() {
    late final clientId = dotenv.env['CLIENT_ID'];
    late final secret = dotenv.env['SPOTIFY_SECRET'];

    return base64Encode(utf8.encode('$clientId:$secret'));
  }
}
