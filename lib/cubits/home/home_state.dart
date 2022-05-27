part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loadingInProgress() = LoadingInProgress;
  const factory HomeState.loadedSuccessfully(List<Album> albums) = LoadedSuccessfully;
  //TODO: change loadedWithError for dartz purposes
  const factory HomeState.loadedWithError(String message) = LoadedWithError;
}
