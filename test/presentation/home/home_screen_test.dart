import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/exceptions/network_exception.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/home/home_screen.dart';
import 'package:bloc_learning/presentation/home/widgets/refresh_button.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFakeArticleRepository extends Mock implements FakeArticleRepository {}

void main() {
  late MockFakeArticleRepository mockRepo;

  const List<Article> articleList = <Article>[
    Article(
      id: 1,
      title: 't1',
      content: 'c1',
      views: 1,
    ),
  ];

  setUp(() {
    mockRepo = MockFakeArticleRepository();
  });

  void arangeArticlesInstantyly() {
    when(() => mockRepo.getArticles()).thenAnswer(
      (_) async {
        return articleList;
      },
    );
  }

  void arangeArticlesWithDelay(Duration duration) {
    when(() => mockRepo.getArticles()).thenAnswer(
      (_) async {
        await Future.delayed(duration);

        return articleList;
      },
    );
  }

  void arangeErrorWithMessage(String message) {
    when(() => mockRepo.getArticles()).thenThrow(NetworkException(message));
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pl', ''), // Polish, no country code
      ],
      home: Scaffold(
        body: BlocProvider(
          create: (ctx) => ArticlesBloc(mockRepo)..add(const LoadArticles()),
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
        arangeArticlesWithDelay(const Duration(seconds: 2));
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));
        expect(
          find.byType(LoadingIndicator),
          findsOneWidget,
        );
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      'should display articles',
      (WidgetTester tester) async {
        arangeArticlesInstantyly();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsNothing);
        for (final Article article in articleList) {
          expect(find.text(article.title), findsOneWidget);
        }
      },
    );
    testWidgets(
      'should display error message when articles loading fails',
      (WidgetTester tester) async {
        const errorMessage = 'error message, smth went wrong';
        arangeErrorWithMessage(errorMessage);
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byType(LoadingIndicator), findsNothing);
        expect(find.byType(ErrorMessage), findsOneWidget);
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'should reload articles when refresh button is pressed',
      (WidgetTester tester) async {
        arangeArticlesInstantyly();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();
        await tester.tap(find.byType(RefreshButton));
        await tester.pump();
        for (final Article articel in articleList) {
          expect(find.text(articel.title), findsOneWidget);
        }
      },
    );
    testWidgets(
      'should display snackbar on refresh with error when articles were previously loaded successfully',
      (WidgetTester tester) async {
        const errorMessage = 'error message, smth went wrong';

        arangeArticlesInstantyly();

        final Widget wut = createWidgetUnderTest();
        await tester.pumpWidget(wut);

        arangeErrorWithMessage(errorMessage);

        await tester.tap(find.byType(RefreshButton));

        await tester.pump(const Duration(milliseconds: 200));
        expect(find.byType(SnackBar), findsOneWidget);

        await tester.pump();
      },
    );
  });
}

class MockArticlesBloc extends MockBloc<ArticlesEvent, ArticlesState>
    implements ArticlesBloc {}
