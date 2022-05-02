import 'package:bloc/bloc.dart';
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
    on<ArticlesEvent>((event, emit) async {
      if (event is LoadArticles) {
        emit(ArticlesState.loading());
        try {
          final articles = await articleRepository.getArticles();
          emit(ArticlesState.loaded(articles));
        } catch (error) {
          emit(ArticlesState.error(error.toString()));
        }
      }
      // if (event is ToggleFavouriteArticle) {
      //   final Article article = state.articles.firstWhere(
      //     (article) => article.id == event.id,
      //   );
      //   final updatedArticle = article.copyWith(
      //     isFavorite: !article.isFavorite,
      //   );
      //   List<Article> newArticles =
      //       (state.articles as List<Article>).map((Article a) {
      //     if (a.id == event.id) {
      //       return updatedArticle;
      //     }
      //     return a;
      //   }).toList();

      //   emit(ArticlesState.loaded(newArticles));
      // }
    });
    // on<GetArticles>((event, emit) async {
    //   emit(ArticlesLoading());
    //   try {
    //     final articles = await articleRepository.getArticles();
    //     emit(ArticlesLoaded(articles));
    //   } catch (error) {
    //     emit(ArticlesError(error.toString()));
    //   }
    // });
    // on<GetArticleByID>(
    //   (event, emit) async {
    //     emit(SingleArticleLoading());
    //     try {
    //       final article = await articleRepository.getArticleByID(event.id);
    //       emit(SingleArticleLoaded(article));
    //     } catch (error) {
    //       emit(SingleArticleError(error.toString()));
    //     }
    //   },
    // );
    // on<ArticleToggleFavorite>(
    //   (event, emit) {
    //     print('test');
    //     final Article article = state.articles.firstWhere(
    //       (article) => article.id == event.id,
    //     );
    //     final updatedArticle = article.copyWith(
    //       isFavorite: !article.isFavorite,
    //     );
    //     List<Article> newArticles =
    //         (state.articles as List<Article>).map((Article a) {
    //       if (a.id == event.id) {
    //         return updatedArticle;
    //       }
    //       return a;
    //     }).toList();

    //     emit(ArticlesLoaded(newArticles));
    //   },
    // );
  }
}
