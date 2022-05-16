import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc(this.articleRepository) : super(const _Initial()) {
    on<ArticleEvent>((event, emit) async {
      if (event is LoadSingleArticle) {
        emit(const ArticleState.loading());
        try {
          final article = await articleRepository.getArticleByID(event.id);
          emit(ArticleState.loaded(article));
        } catch (error) {
          emit(ArticleState.error(error.toString()));
        }
      }
    });
  }
  final ArticleRepository articleRepository;
}
