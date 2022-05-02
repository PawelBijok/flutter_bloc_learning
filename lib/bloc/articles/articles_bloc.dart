import 'package:bloc/bloc.dart';
import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../data/articles_repository.dart';
import '../../models/article/article.dart';

part 'articles_event.dart';
part 'articles_state.dart';
part 'articles_bloc.freezed.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticleRepository articleRepository;

  ArticlesBloc(this.articleRepository) : super(_Initial()) {
    on<LoadArticles>(((event, emit) async {
      final List<Article> oldArticles = state.articles;
      emit(const ArticlesState.loading());
      try {
        final articles = await articleRepository.getArticles();
        emit(ArticlesState.loaded(articles));
      } catch (error) {
        if (oldArticles.isNotEmpty) {
          emit(ArticlesState.loadedWithError(oldArticles, error.toString()));
          return;
        }
        emit(ArticlesState.error(error.toString()));
      }
    }));
    on<ToggleFavouriteArticle>(((event, emit) {
      final int articleIndex = state.articles.indexWhere(
        (article) => article.id == event.id,
      );
      if (articleIndex == -1) {
        emit(
            ArticlesState.loadedWithError(state.articles, 'Article not found'));
        return;
      }
      final article = state.articles[articleIndex];
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

      emit(ArticlesState.loaded(newArticles));
    }));
  }
}
