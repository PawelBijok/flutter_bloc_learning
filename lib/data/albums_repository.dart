import 'package:bloc_learning/data/api/spotify_api.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/models/album/album_failure.dart';
import 'package:bloc_learning/models/dtos/result_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AlbumsRepository {
  Future<Either<AlbumFailure, List<Album>>> getAlbums([int? offset]);
  Future<Either<AlbumFailure, Album>> getAlbumDetails(String id);
}

class AlbumsRepositoryImplementation implements AlbumsRepository {
  AlbumsRepositoryImplementation(this._spotifyApi);
  final SpotifyApi _spotifyApi;
  @override
  Future<Either<AlbumFailure, List<Album>>> getAlbums([int? offset]) async {
    try {
      final apiData = await _spotifyApi.fetchNewReleasesAlbums(offset);
      final List<Album> items = ResultDto.fromJson(apiData).albums.items;

      return Right(items);
    } on DioError catch (_) {
      return const Left(AlbumFailure.unexpected());
    }
  }

  @override
  Future<Either<AlbumFailure, Album>> getAlbumDetails(String id) async {
    try {
      final Map<String, dynamic> albumJson = await _spotifyApi.fetchAlbumDetails(id);
      final Album album = Album.fromJson(albumJson);

      return Right(album);
    } on DioError catch (_) {
      return const Left(AlbumFailure.unexpected());
    }
  }
}
