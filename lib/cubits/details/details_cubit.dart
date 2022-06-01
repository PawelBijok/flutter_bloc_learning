import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/repositories/albums_repository.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_state.dart';
part 'details_cubit.freezed.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.albumsRepository) : super(const DetailsState.initial());
  final AlbumsRepository albumsRepository;

  Future<void> loadAlbumDetails(String id) async {
    emit(const LoadingInProgress());

    final albumOrFailure = await albumsRepository.getAlbumDetails(id);
    albumOrFailure.fold(
      (f) {
        emit(LoadedWithError(f.toString()));
      },
      (album) {
        emit(LoadedSuccessfully(album));
      },
    );
  }
}
