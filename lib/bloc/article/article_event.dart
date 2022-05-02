part of 'article_bloc.dart';

@freezed
class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.loadSingleArticle(int id) = LoadSingleArticle;
}
