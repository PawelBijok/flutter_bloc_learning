import 'package:bloc_learning/cubits/details/details_cubit.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/details/widgets/artist_and_name.dart';
import 'package:bloc_learning/presentation/details/widgets/sliver_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.album, required this.albumId, Key? key}) : super(key: key);
  final Album album;
  final String albumId;
  static const routeName = 'album/:id';

  static String generateRoute(String id) {
    return '/album/$id';
  }

  @override
  Widget build(BuildContext context) {
    context.read<DetailsCubit>().loadAlbumDetails(albumId);

    return Scaffold(
      body: _Body(album: album),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.album, Key? key}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverImage(album: album),
        ArtistAndName(album: album),
        BlocBuilder<DetailsCubit, DetailsState>(builder: (_, state) {
          return state.when(
            initial: () => const LoadingIndicator.forSlivers(),
            loadingInProgress: () => const LoadingIndicator.forSlivers(),
            // TODO: populate LoadedSuccessfully state
            loadedSuccessfully: (_) => const SliverToBoxAdapter(),
            loadedWithError: ErrorMessage.forSlivers,
          );
        }),
      ],
    );
  }
}
