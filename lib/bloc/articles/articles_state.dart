part of 'articles_bloc.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const factory ArticlesState.initial() = _Initial;
  const factory ArticlesState.loading() = _Loading;
  const factory ArticlesState.loaded(List<Article> articles) = _Loaded;
  const factory ArticlesState.error(String message) = _Error;

  // get articles => [];
}
