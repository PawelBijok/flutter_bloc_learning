import 'dart:convert';

import 'package:bloc_learning/data/albums_repository.dart';
import 'package:bloc_learning/data/api/spotify_api.dart';
import 'package:bloc_learning/exceptions/network_exception.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockSpotifyApi extends Mock implements SpotifyApi {}

void main() {
  late AlbumsRepository sut;
  late MockSpotifyApi mockSpotifyApi;

  setUp(() {
    mockSpotifyApi = MockSpotifyApi();
    sut = AlbumsRepositoryImplementation(mockSpotifyApi);
  });

  void assertNewReleases() {
    when(() => mockSpotifyApi.fetchNewReleasesAlbums(any())).thenAnswer((_) async {
      final dataString = jsonDecode(fixture('new_releases_albums_response_body.json'));

      return dataString;
    });
  }

  void assertAlbumDetails() {
    when(() => mockSpotifyApi.fetchAlbumDetails(any())).thenAnswer((_) async {
      final dataString = jsonDecode(fixture('album_response_body.json'));

      return dataString;
    });
  }

  group('Albums Repository Implementation', () {
    group('GertNewReleases funcion', () {
      test(
        'calls fetchNewReleasesAlbums',
        () async {
          assertNewReleases();
          await sut.getAlbums();
          verify(() => mockSpotifyApi.fetchNewReleasesAlbums()).called(1);
        },
      );
      test(
        'accepts and pass optional positional argument "offset"',
        () async {
          assertNewReleases();
          await sut.getAlbums(20);
          verify(() => mockSpotifyApi.fetchNewReleasesAlbums(20)).called(1);
        },
      );
      test(
        'rethrows error when api does',
        () async {
          const errorMessage = 'smth went wrong';
          when(() => mockSpotifyApi.fetchNewReleasesAlbums()).thenThrow(NetworkException(errorMessage));

          expect(
            () => sut.getAlbums(),
            throwsA(
              isA<NetworkException>().having((e) => e.message, 'message', errorMessage),
            ),
          );
        },
      );
      test(
        'converts api response to list of albums',
        () async {
          assertNewReleases();
          final resultOrFailure = await sut.getAlbums();
          late final List<Album> result;
          resultOrFailure.fold((f) => null, (albums) {
            result = albums;
          });
          expect(result, isA<List<Album>>());
          expect(result.length, equals(2));
        },
      );
    });

    group('GetAlbumDetails funcion', () {
      test(
        'calls fetchAlbumDetails',
        () async {
          assertAlbumDetails();
          await sut.getAlbumDetails('123');
          verify(() => mockSpotifyApi.fetchAlbumDetails('123')).called(1);
        },
      );

      test(
        'rethrows error when api does',
        () async {
          const errorMessage = 'smth went wrong';
          when(() => mockSpotifyApi.fetchAlbumDetails('123')).thenThrow(NetworkException(errorMessage));

          expect(
            () => sut.getAlbumDetails('123'),
            throwsA(
              isA<NetworkException>().having((e) => e.message, 'message', errorMessage),
            ),
          );
        },
      );
      test(
        'converts api response to  albums',
        () async {
          assertAlbumDetails();
          final resultOrFailure = await sut.getAlbumDetails('123');
          late final Album result;
          resultOrFailure.fold((f) => null, (albums) {
            result = albums;
          });
          expect(result, isA<Album>());
        },
      );
    });
  });
}
