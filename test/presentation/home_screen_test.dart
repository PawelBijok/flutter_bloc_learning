import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/data/articles_provider.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:bloc_learning/presentation/home_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFakeArticleRepository extends Mock implements FakeArticleRepository {}

void main() {
  late MockFakeArticleRepository mockRepo;
  late ArticleBloc articleBloc;

  const List<Article> articleList = <Article>[
    Article(id: 1, title: 't1', content: 'c1', views: 1)
  ];

  setUp(() {
    mockRepo = MockFakeArticleRepository();
    articleBloc = ArticleBloc(mockRepo);
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
      home: Scaffold(
        body: BlocProvider(
          create: (ctx) => ArticlesBloc(mockRepo)..add(LoadArticles()),
          child: const HomeScreen(),
        ),
      ),
    );
  }

  group('home screen tests', () {
    testWidgets(
      "should display loading indicator at the beginning",
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        final loadingIndicator =
            find.byKey(const Key('test__loading-indicator'));

        expect(loadingIndicator, findsOneWidget);
      },
    );
    testWidgets(
      "should display loading while articles are loading",
      (WidgetTester tester) async {
        arangeArticlesWithDelay(Duration(seconds: 2));
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(milliseconds: 500));
        expect(
            find.byKey(const Key('test__loading-indicator')), findsOneWidget);
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      "should display articles",
      (WidgetTester tester) async {
        // clear(mockRepo)
        arangeArticlesInstantyly();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byKey(const Key('test__loading-indicator')), findsNothing);
        for (Article article in articleList) {
          expect(find.text(article.title), findsOneWidget);
        }
      },
    );
    testWidgets(
      "should display error message when articles loading fails",
      (WidgetTester tester) async {
        const errorMessage = 'error message, smth went wrong';
        arangeErrorWithMessage(errorMessage);
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        expect(find.byKey(const Key('test__loading-indicator')), findsNothing);
        expect(find.byKey(const Key('test__error-message')), findsOneWidget);
        expect(find.text(errorMessage), findsOneWidget);
      },
    );
    testWidgets(
      "should display snackbar on refresh with error when articles were previously loaded successfully",
      (WidgetTester tester) async {
        const errorMessage = 'error message, smth went wrong';

        arangeArticlesInstantyly();

        Widget wut = createWidgetUnderTest();
        await tester.pumpWidget(wut);

        arangeErrorWithMessage(errorMessage);

        await tester.tap(find.byKey(const Key('test__refresh-button')));

        await tester.pump(Duration(milliseconds: 200));
        expect(find.byType(SnackBar), findsOneWidget);

        await tester.pump();
      },
    );
  });
}

class MockArticlesBloc extends MockBloc<ArticlesEvent, ArticlesState>
    implements ArticlesBloc {}
