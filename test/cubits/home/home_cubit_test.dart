import 'package:bloc_learning/cubits/home/home_cubit.dart';
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
  late HomeCubit homeCubit;
  late MockAlbumsRepository mockRepo;

  setUp(() {
    mockRepo = MockAlbumsRepository();
    homeCubit = HomeCubit(mockRepo);
  });

  group('Home cubit', () {
    blocTest(
      '''
      emits LoadingInProgress then
      emits LoadedSuccessfully with correct albums
      when loadAlbums() function is ran
      ''',
      build: () {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Right(fakeAlbumsList));

        return homeCubit;
      },
      act: (HomeCubit cubit) => cubit.loadAlbums(),
      expect: () => const [LoadingInProgress(), LoadedSuccessfully(fakeAlbumsList)],
    );
    blocTest(
      '''
      emits LoadingInProgress then
      emits LoadedWithError
      when loadAlbums() function fails
      ''',
      build: () {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Left(failure));

        return homeCubit;
      },
      act: (HomeCubit cubit) => cubit.loadAlbums(),
      expect: () => [const LoadingInProgress(), LoadedWithError(failure.toString())],
    );

    blocTest(
      '''
      emits AlbumsLoaded with correct albums
      when refresh() function is ran
      ''',
      build: () {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Right(fakeAlbumsList));

        return homeCubit;
      },
      act: (HomeCubit cubit) => cubit.refresh(),
      expect: () => const [LoadedSuccessfully(fakeAlbumsList)],
    );

    blocTest(
      '''
      emits LoadedWithError
      when refresh() function fails
      ''',
      build: () {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Left(failure));

        return homeCubit;
      },
      act: (HomeCubit cubit) => cubit.refresh(),
      expect: () => [LoadedWithError(failure.toString())],
    );
    blocTest(
      '''
      emits LoadedSuccessfully
      when loadMoreAlbums() function is ran
      ''',
      build: () {
        return homeCubit;
      },
      act: (cubit) async {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Right(fakeAlbumsList));
        await homeCubit.loadAlbums();
        when(() => mockRepo.getAlbums(fakeAlbumsList.length)).thenAnswer((_) async => const Right(fakeAlbumsList2));
        await homeCubit.loadMoreAlbums();
      },
      skip: 2,
      expect: () => const [
        LoadedSuccessfully(
          [...fakeAlbumsList, ...fakeAlbumsList2],
        ),
      ],
    );
    blocTest(
      '''
      emits LoadedWithError
      when loadMoreAlbums() function is ran and fails
      ''',
      build: () {
        return homeCubit;
      },
      act: (cubit) async {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Right(fakeAlbumsList));
        await homeCubit.loadAlbums();
        when(() => mockRepo.getAlbums(1)).thenAnswer((_) async => const Left(failure));
        await homeCubit.loadMoreAlbums();
      },
      skip: 2,
      expect: () => [LoadedWithError(failure.toString())],
    );
    blocTest(
      '''
      emits LoadingInProgress and LoadedSuccesfully
      when loadMoreAlbums() function is ran
      but there is no albums in previous state
      ''',
      build: () {
        return homeCubit;
      },
      act: (cubit) {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Right(fakeAlbumsList));
        homeCubit.loadMoreAlbums();
      },
      expect: () => const [LoadingInProgress(), LoadedSuccessfully(fakeAlbumsList)],
    );
    blocTest(
      '''
      emits LoadedWithError 
      when loadMoreAlbums() function is ran
      but there is no albums in previous state
      and loadAlbums() function throws an error
      ''',
      build: () {
        return homeCubit;
      },
      act: (cubit) {
        when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Left(failure));
        homeCubit.loadMoreAlbums();
      },
      skip: 1,
      expect: () => [LoadedWithError(failure.toString())],
    );
  });
}
