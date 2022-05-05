import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bloc_learning/models/article/article.dart';

import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/data/articles_repository.dart';

import 'package:bloc_learning/presentation/home/widgets/article_item.dart';

class MockFakeArticleRepository extends Mock implements FakeArticleRepository {}

void main() {
  late MockFakeArticleRepository mockRepo;

  const List<Article> articleList = <Article>[
    Article(id: 1, title: 't1', content: 'c1', views: 1, isFavorite: false),
  ];

  setUp(() {
    mockRepo = MockFakeArticleRepository();
  });

  Widget createTestWidgetWithData({Article? article}) {
    return MaterialApp(
      home: Scaffold(
        body: ArticleItem(article ??
            const Article(
                id: 1, title: 'test', content: 'test_content', views: 1)),
      ),
    );
  }

  Widget createTestWidgetWithBlocProvider() {
    return BlocProvider(
      create: (ctx) => ArticlesBloc(mockRepo)..add(const LoadArticles()),
      child: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, state) {
          Article? article;
          state.when(
              initial: () {},
              loading: () {},
              loaded: (articles) {
                article = articles.first;
              },
              loadedWithError: (_, __) {},
              error: (_) {});
          return createTestWidgetWithData(article: article);
        },
      ),
    );
  }

  group('views counter tests', () {
    testWidgets(
      "views icon and views counter is shown when views count is greater than 0",
      (WidgetTester tester) async {
        const Article fakeArticle =
            Article(id: 1, title: 't1', content: 'c1', views: 12);
        await tester.pumpWidget(createTestWidgetWithData(article: fakeArticle));
        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.text('12'), findsOneWidget);
      },
    );

    testWidgets(
      "views icon and views counter is not shown when views count is 0",
      (WidgetTester tester) async {
        const Article fakeArticle =
            Article(id: 1, title: 't1', content: 'c1', views: 0);

        await tester.pumpWidget(createTestWidgetWithData(article: fakeArticle));

        expect(find.byIcon(Icons.visibility), findsNothing);
        expect(find.text('0'), findsNothing);
      },
    );
  });

  group('favourite icon tests', () {
    testWidgets(
      "favourite icon is outlined when article is not favourite",
      (WidgetTester tester) async {
        const fakeArticle = Article(
            id: 0, title: 't1', content: 'c1', views: 1, isFavorite: false);
        await tester.pumpWidget(createTestWidgetWithData(article: fakeArticle));
        expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
      },
    );
    testWidgets(
      "favourite icon is filled when article is favourite",
      (WidgetTester tester) async {
        const fakeArticle = Article(
            id: 0, title: 't1', content: 'c1', views: 1, isFavorite: true);
        await tester.pumpWidget(createTestWidgetWithData(article: fakeArticle));
        expect(find.byIcon(Icons.bookmark), findsOneWidget);
      },
    );

    testWidgets(
      "taping favourite icon toggles favourite status",
      (WidgetTester tester) async {
        when(() => mockRepo.getArticles()).thenAnswer(
          (_) async {
            return articleList;
          },
        );
        await tester.pumpWidget(createTestWidgetWithBlocProvider());
        await tester.pump();
        final favButton = find.byKey(const Key('test__favorite-button'));
        expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
        await tester.tap(favButton);
        await tester.pump();
        expect(find.byIcon(Icons.bookmark), findsOneWidget);
        expect(find.byIcon(Icons.bookmark_outline), findsNothing);
        await tester.tap(favButton);
        await tester.pump();
        expect(find.byIcon(Icons.bookmark), findsNothing);
        expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
      },
    );
  });
}
