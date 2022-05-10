import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'articles_event.dart';
part 'articles_state.dart';
part 'articles_bloc.freezed.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  // ignore: long-method
  ArticlesBloc(this.articleRepository) : super(const Initial()) {
    on<LoadArticles>((event, emit) async {
      List<Article>? oldArticles;
      if (state is Loaded) {
        oldArticles = (state as Loaded).articles;
      } else if (state is LoadedWithError) {
        oldArticles = (state as LoadedWithError).articles;
      } else {
        oldArticles = null;
      }

      emit(const ArticlesState.loading());
      try {
        final articles = await articleRepository.getArticles();
        emit(ArticlesState.loaded(articles));
      } catch (error) {
        if (oldArticles != null) {
          emit(ArticlesState.loadedWithError(oldArticles, error.toString()));

          return;
        }
        emit(ArticlesState.error(error.toString()));
      }
    });

    on<ToggleFavouriteArticle>((event, emit) {
      late final int articleIndex;
      if (state is Loaded) {
        articleIndex = (state as Loaded).articles.indexWhere(
              (article) => article.id == event.id,
            );
      } else if (state is LoadedWithError) {
        articleIndex = (state as LoadedWithError).articles.indexWhere(
              (article) => article.id == event.id,
            );
      } else {
        articleIndex = -1;
      }
      if (articleIndex == -1) {
        emit(
          ArticlesState.loadedWithError(
            (state as Loaded).articles,
            'Article not found',
          ),
        );

        return;
      }
      final article = (state as Loaded).articles[articleIndex];
      final updatedArticle = article.copyWith(
        isFavorite: !article.isFavorite,
      );
      final List<Article> newArticles =
          ((state as Loaded).articles).map((Article a) {
        if (a.id == event.id) {
          return updatedArticle;
        }

        return a;
      }).toList();

      emit(ArticlesState.loaded(newArticles));
    });
  }
  final ArticleRepository articleRepository;
}
