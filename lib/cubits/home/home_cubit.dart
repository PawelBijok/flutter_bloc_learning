import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/repositories/albums_repository.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.albumsRepository) : super(const HomeState.initial());

  final AlbumsRepository albumsRepository;

  Future<void> _getAlbums() async {
    final albumsOrFailure = await albumsRepository.getAlbums();
    albumsOrFailure.fold(
      (f) {
        emit(HomeState.loadedWithError(f.toString()));
      },
      (albums) {
        emit(HomeState.loadedSuccessfully(albums));
      },
    );
  }

  Future<void> loadAlbums() async {
    emit(const HomeState.loadingInProgress());

    return _getAlbums();
  }

  Future<void> refresh() async {
    return _getAlbums();
  }

  Future<void> loadMoreAlbums() async {
    List<Album>? oldALbums;
    if (state is LoadedSuccessfully) {
      oldALbums = (state as LoadedSuccessfully).albums;
    }
    if (oldALbums == null) {
      await loadAlbums();

      return;
    }

    final albumsOrFailure = await albumsRepository.getAlbums(oldALbums.length);
    albumsOrFailure.fold(
      (f) {
        emit(HomeState.loadedWithError(f.toString()));
      },
      (albums) {
        emit(HomeState.loadedSuccessfully([...oldALbums!, ...albums]));
      },
    );
  }
}
