import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/articles_repository.dart';
import '../models/article/article.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleRepository articleRepository;

  ArticlesBloc(this.articleRepository) : super(ArticlesInitial()) {
    on<GetArticles>((event, emit) async {
      emit(ArticlesLoading());
      try {
        final articles = await articleRepository.getArticles();
        emit(ArticlesLoaded(articles));
      } catch (error) {
        emit(ArticlesError(error.toString()));
      }
    });
    on<GetArticleByID>(
      (event, emit) async {
        emit(SingleArticleLoading());
        try {
          final article = await articleRepository.getArticleByID(event.id);
          emit(SingleArticleLoaded(article));
        } catch (error) {
          emit(SingleArticleError(error.toString()));
        }
      },
    );
    on<ArticleToggleFavorite>(
      (event, emit) {
        print('test');
        final Article article = state.articles.firstWhere(
          (article) => article.id == event.id,
        );
        final updatedArticle = article.copyWith(
          isFavorite: !article.isFavorite,
        );
        List<Article> newArticles =
            (state.articles as List<Article>).map((Article a) {
          if (a.id == event.id) {
            return updatedArticle;
          }
          return a;
        }).toList();

        emit(ArticlesLoaded(newArticles));
      },
    );
  }
}
