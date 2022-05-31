import 'package:bloc_learning/cubits/home/home_cubit.dart';
import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/data/repositories/albums_repository.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/models/album/album_failure.dart';

import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/home/home_screen.dart';
import 'package:bloc_learning/presentation/home/widgets/albums_grid.dart';
import 'package:bloc_learning/presentation/home/widgets/drawer/home_drawer.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import '../../fakes/albums_lists.dart';

class MockAlbumsRepository extends Mock implements AlbumsRepository {}

class MockStorage extends Mock implements Storage {}

void main() {
  late MockAlbumsRepository mockRepo;
  late HomeCubit homeCubit;
  late ThemeCubit themeCubit;
  late MockStorage mockStorage;
  const AlbumFailure failure = AlbumFailure.unexpected();

  setUp(() async {
    mockStorage = MockStorage();

    when(
      () => mockStorage.write(
        any(),
        any<dynamic>(),
      ),
    ).thenAnswer(
      (_) async {},
    );
    when<dynamic>(
      () => mockStorage.read(
        any(),
      ),
    ).thenReturn(<String, dynamic>{});

    HydratedBlocOverrides.runZoned(
      () {
        return themeCubit = ThemeCubit();
      },
      storage: mockStorage,
    );

    mockRepo = MockAlbumsRepository();
    homeCubit = HomeCubit(mockRepo);
  });

  void arangeAlbumsInstantyly(List<Album> albums) {
    when(() => mockRepo.getAlbums()).thenAnswer(
      (_) async {
        return Right(albums);
      },
    );
  }

  void arangeAlbumsWithDelay(Duration duration, List<Album> albums) {
    when(() => mockRepo.getAlbums()).thenAnswer(
      (_) async {
        await Future.delayed(duration);

        return Right(albums);
      },
    );
  }

  void arangeErrorWithMessage(String message) {
    when(() => mockRepo.getAlbums()).thenAnswer((_) async => const Left(failure));
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => homeCubit),
            BlocProvider(create: (ctx) => themeCubit),
          ],
          child: const HomeScreen(),
        ),
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets(
      'should display loading indicator at the beginning',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        final loadingIndicator = find.byType(LoadingIndicator);

        expect(loadingIndicator, findsOneWidget);
      },
    );
    testWidgets(
      'should display loading while articles are loading',
      (WidgetTester tester) async {
        arangeAlbumsWithDelay(const Duration(seconds: 2), fakeAlbumsList);
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(LoadingIndicator),
          findsOneWidget,
        );
      },
    );
    testWidgets(
      'should display articles',
      (WidgetTester tester) async {
        arangeAlbumsInstantyly(fakeAlbumsList);
        await tester.pumpWidget(createWidgetUnderTest());
        await homeCubit.loadAlbums();
        await tester.pumpAndSettle();

        expect(find.byType(LoadingIndicator), findsNothing);
        for (final Album album in fakeAlbumsList) {
          expect(find.text(album.name), findsOneWidget);
        }
      },
    );
    testWidgets(
      'should display error message when articles loading fails',
      (WidgetTester tester) async {
        const errorMessage = 'error message, smth went wrong';
        arangeErrorWithMessage(errorMessage);
        await tester.pumpWidget(createWidgetUnderTest());
        await homeCubit.loadAlbums();
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsNothing);
        expect(find.byType(ErrorMessage), findsOneWidget);
      },
    );
    testWidgets(
      'should reload articles when pulled down from top',
      (WidgetTester tester) async {
        arangeAlbumsInstantyly(fakeAlbumsList);
        await tester.pumpWidget(createWidgetUnderTest());
        await homeCubit.loadAlbums();

        arangeAlbumsInstantyly(fakeAlbumsList2);
        await tester.pump(const Duration(milliseconds: 50));

        await tester.drag(find.byType(AlbumsGrid), const Offset(0, 100));

        await tester.pumpAndSettle(const Duration(milliseconds: 50));
        for (final Album album in fakeAlbumsList2) {
          expect(find.text(album.name), findsOneWidget);
        }
      },
    );

    testWidgets(
      'should open drawer after swiping from left',
      (WidgetTester tester) async {
        arangeAlbumsInstantyly(fakeAlbumsList);
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.dragFrom(
          tester.getTopLeft(
            find.byType(HomeScreen),
          ),
          const Offset(200, 0),
        );
        await tester.pump();
        expect(find.byType(HomeDrawer), findsOneWidget);
      },
    );
  });
}
