part of 'articles_bloc.dart';

@freezed
class ArticlesEvent with _$ArticlesEvent {
  const factory ArticlesEvent.loadArticles() = LoadArticles;
  const factory ArticlesEvent.toggleFavouriteArticle(int id) =
      ToggleFavouriteArticle;
}
