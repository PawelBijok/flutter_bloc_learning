import 'package:bloc_learning/bloc/articles_bloc.dart';
import 'package:bloc_learning/data/articles_provider.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// class MockArticlesBlock extends MockBloc<ArticlesEvent, ArticlesState>
//     implements ArticlesBloc {}

class MockArticleRepository extends Mock implements ArticleRepository {}

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
    Article(
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
      act: (ArticlesBloc bloc) => bloc.add(GetArticles()),
      expect: () => [ArticlesLoading(), ArticlesLoaded(articlesList)],
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
      act: (ArticlesBloc bloc) => bloc.add(GetArticles()),
      expect: () => [ArticlesLoading(), ArticlesError(errorMessage)],
    );
  });

  // blocTest('fetches articles', build: build)
}
