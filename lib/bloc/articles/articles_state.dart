part of 'articles_bloc.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const ArticlesState._();
  const factory ArticlesState.initial() = Initial;
  const factory ArticlesState.loading() = Loading;
  const factory ArticlesState.loaded(List<Article> articles) = Loaded;
  const factory ArticlesState.loadedWithError(
    List<Article> articles,
    String message,
  ) = LoadedWithError;
  const factory ArticlesState.error(String message) = Error;
}
