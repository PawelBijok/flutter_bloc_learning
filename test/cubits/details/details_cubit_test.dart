import 'package:bloc_learning/cubits/details/details_cubit.dart';
import 'package:bloc_learning/data/repositories/albums_repository.dart';
import 'package:bloc_learning/models/album/album_failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../fakes/albums_lists.dart';

class MockAlbumsRepository extends Mock implements AlbumsRepository {}

const AlbumFailure failure = AlbumFailure.unexpected();
void main() {
  late DetailsCubit detailsCubit;
  late MockAlbumsRepository mockRepo;

  setUp(() {
    mockRepo = MockAlbumsRepository();
    detailsCubit = DetailsCubit(mockRepo);
  });

  group('Home cubit', () {
    blocTest(
      '''
      emits LoadingInProgress then
      emits LoadedSuccessfully with correct albums
      when loadAlbumDetails() function is ran
      ''',
      build: () {
        when(() => mockRepo.getAlbumDetails(any())).thenAnswer((_) async => Right(fakeAlbumsList[0]));

        return detailsCubit;
      },
      act: (DetailsCubit cubit) => cubit.loadAlbumDetails('123'),
      expect: () => [const LoadingInProgress(), LoadedSuccessfully(fakeAlbumsList[0])],
    );
    blocTest(
      '''
      emits LoadingInProgress then
      emits LoadedWithError
      when loadAlbumsDetails() function fails
      ''',
      build: () {
        when(() => mockRepo.getAlbumDetails(any())).thenAnswer((_) async => const Left(failure));

        return detailsCubit;
      },
      act: (DetailsCubit cubit) => cubit.loadAlbumDetails('123'),
      expect: () => [const LoadingInProgress(), LoadedWithError(failure.toString())],
    );
  });
}
