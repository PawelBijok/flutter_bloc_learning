part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState extends Equatable {
  get articles => null;
}

class ArticlesInitial extends ArticlesState {
  ArticlesInitial();

  @override
  List<Object?> get props => [];
}

class ArticlesLoading extends ArticlesState {
  ArticlesLoading();

  @override
  List<Object?> get props => [];
}

class SingleArticleLoading extends ArticlesState {
  SingleArticleLoading();

  @override
  List<Object?> get props => [];
}

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);

  List<Object?> get props => [articles];
}

class SingleArticleLoaded extends ArticlesState {
  final Article article;

  SingleArticleLoaded(this.article);

  @override
  List<Object?> get props => [article];
}

class ArticlesError extends ArticlesState {
  final String message;

  ArticlesError(this.message);

  @override
  List<Object?> get props => [message];
}

class SingleArticleError extends ArticlesState {
  final String message;

  SingleArticleError(this.message);

  @override
  List<Object?> get props => [message];
}
