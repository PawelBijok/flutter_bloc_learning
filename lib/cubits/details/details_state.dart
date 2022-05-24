part of 'details_cubit.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState.initial() = _Initial;
  const factory DetailsState.loadingInProgress() = LoadingInProgress;
  const factory DetailsState.loadedSuccessfully(Album album) = LoadedSuccessfully;
  const factory DetailsState.loadedWithError(String message) = LoadedWithError;
}
