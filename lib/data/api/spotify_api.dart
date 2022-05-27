import 'dart:async';

import 'package:dio/dio.dart';

class SpotifyApi {
  SpotifyApi({required this.dio});

  final Dio dio;

  Future<Map<String, dynamic>> fetchNewReleasesAlbums([int? offset]) async {
    final offsetQuery = offset != null ? '?offset=$offset' : '';
    final response = await dio.get('/browse/new-releases$offsetQuery');

    return response.data;
  }

  Future<Map<String, dynamic>> fetchAlbumDetails(String id) async {
    final response = await dio.get('/albums/$id');

    return response.data;
  }
}
