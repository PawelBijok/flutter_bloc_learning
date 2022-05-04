part of 'articles_bloc.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const ArticlesState._();
  const factory ArticlesState.initial() = _Initial;
  const factory ArticlesState.loading() = _Loading;
  const factory ArticlesState.loaded(List<Article> articles) = _Loaded;
  const factory ArticlesState.loadedWithError(
      List<Article> articles, String message) = _LoadedWithError;
  const factory ArticlesState.error(String message) = _Error;
  List<Article> get articles => [];
}
