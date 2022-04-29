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
    on<GetArticlByID>(
      (event, emit) {
        throw UnimplementedError();
      },
    );
  }
}
