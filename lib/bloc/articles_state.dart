part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState {
  get articles => null;
}

class ArticlesInitial extends ArticlesState {
  ArticlesInitial();
}

class ArticlesLoading extends ArticlesState {
  ArticlesLoading();
}

class SingleArticleLoading extends ArticlesState {
  SingleArticleLoading();
}

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);
}

class SingleArticleLoaded extends ArticlesState {
  final Article article;

  SingleArticleLoaded(this.article);
}

class ArticlesError extends ArticlesState {
  final String message;

  ArticlesError(this.message);
}

class SingleArticleError extends ArticlesState {
  final String message;

  SingleArticleError(this.message);
}
