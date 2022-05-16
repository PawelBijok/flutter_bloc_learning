import 'package:bloc_learning/data/article_service.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/exceptions/network_exception.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleService extends Mock implements ArticleService {}

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late ArticleRepository sut;
  late MockArticleService mockArticleService;

  setUp(() {
    mockArticleService = MockArticleService();
    sut = FakeArticleRepository(mockArticleService);
  });

  group('Articles repository', () {
    test(
      'calls getArticles from ArticleService',
      () async {
        const articlesString =
            '[{"id": 1, "title": "Article 1", "content": "Content 1", "views": 1}, {"id": 2, "title": "Article 2", "content": "Content 2", "views": 2}, {"id": 3, "title": "Article 3", "content": "Content 3", "views": 3}, {"id": 4, "title": "Article 4", "content": "Content 4", "views": 4}, {"id": 5, "title": "Article 5", "content": "Content 5", "views": 5}]';
        when(() => mockArticleService.getArticles()).thenAnswer(
          (_) async => articlesString,
        );
        await sut.getArticles();
        verify(() => mockArticleService.getArticles()).called(1);
      },
    );
    test(
      'rethtrows an error when service does',
      () {
        const errorMessage = 'smth went wrong';
        when(() => mockArticleService.getArticles())
            .thenThrow(NetworkException(errorMessage));
        expect(
          () => sut.getArticles(),
          throwsA(
            isA<NetworkException>()
                .having((e) => e.message, 'message', errorMessage),
          ),
        );
      },
    );

    test(
      'converts service response to list of articles',
      () async {
        const articlesString =
            '[{"id": 1, "title": "Article 1", "content": "Content 1", "views": 1}, {"id": 2, "title": "Article 2", "content": "Content 2", "views": 2}, {"id": 3, "title": "Article 3", "content": "Content 3", "views": 3}, {"id": 4, "title": "Article 4", "content": "Content 4", "views": 4}, {"id": 5, "title": "Article 5", "content": "Content 5", "views": 5}]';
        when(() => mockArticleService.getArticles()).thenAnswer(
          (_) async => articlesString,
        );
        final result = await sut.getArticles();
        expect(result, isA<List<Article>>());
        expect(result.length, equals(5));
      },
    );

    test(
      'converts service response to a single article',
      () async {
        when(() => mockArticleService.getArticleByID(1)).thenAnswer(
          (_) async =>
              '[{"id": 1, "title": "Article 1", "content": "Content 1", "views": 1}]',
        );
        final result = await sut.getArticleByID(1);
        expect(result, isA<Article>());
        expect(result.id, equals(1));
      },
    );
  });
}
