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

class ArticlesLoaded extends ArticlesState {
  final List<Article> articles;

  ArticlesLoaded(this.articles);
}
