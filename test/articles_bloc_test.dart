import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/data/articles_provider.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockArticlesBlock extends MockBloc<ArticlesEvent, ArticlesState>
//     implements ArticlesBloc {}

class MockArticleRepository extends Mock implements ArticleRepository {}

class MockAticlesBloc extends MockBloc<ArticlesEvent, ArticlesState>
    implements ArticlesBloc {}

void main() {
  late MockArticleRepository mockArticleRepository;
  late ArticlesBloc articlesBloc;
  late String errorMessage;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    articlesBloc = ArticlesBloc(mockArticleRepository);
    errorMessage = 'An error occured';
  });

  List<Article> articlesList = [
    const Article(
        id: 1,
        title: 'Title 1',
        content: 'Contetn 1',
        views: 1,
        isFavorite: false),
  ];

  group('ArticleBloc test', () {
    blocTest(
      """emits ArticlesLoaded with corret articles 
      when GetArticles event is added 
      and ArticleRepository returns data""",
      build: () {
        when(() => mockArticleRepository.getArticles()).thenAnswer(
          (_) async => articlesList,
        );
        return articlesBloc;
      },
      act: (ArticlesBloc bloc) => bloc.add(LoadArticles()),
      expect: () =>
          [const ArticlesState.loading(), ArticlesState.loaded(articlesList)],
    );

    blocTest(
      """emits ArticlesError when GetArticles event is added
       and ArticleRepository throws error""",
      build: () {
        when(() => mockArticleRepository.getArticles()).thenThrow(
          NetworkException(errorMessage),
        );
        return articlesBloc;
      },
      act: (ArticlesBloc bloc) => bloc.add(const LoadArticles()),
      expect: () =>
          [const ArticlesState.loading(), ArticlesState.error(errorMessage)],
    );
    blocTest("""emits LoadedWithError event 
    when LoadArticles is added
    with yet loaded articels and 
    repository throws error""",
        build: () => articlesBloc,
        act: (ArticlesBloc bloc) async {
          when(() => mockArticleRepository.getArticles()).thenAnswer(
            (_) async => articlesList,
          );
          bloc.add(const LoadArticles());
          await Future.delayed(const Duration(milliseconds: 1)).then((_) {
            when(() => mockArticleRepository.getArticles())
                .thenThrow(NetworkException(errorMessage));
          });
          await Future.delayed(const Duration(milliseconds: 1)).then((_) {
            bloc.add(const LoadArticles());
          });
        },
        skip: 2,
        expect: () => [
              const ArticlesState.loading(),
              ArticlesState.loadedWithError(articlesList, errorMessage)
            ]);
  });

  // blocTest('fetches articles', build: build)
}
