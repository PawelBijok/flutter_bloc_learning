import 'package:bloc_learning/cubits/details/details_cubit.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/core/widgets/error_message.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/details/widgets/artist_and_name.dart';
import 'package:bloc_learning/presentation/details/widgets/popularity.dart';
import 'package:bloc_learning/presentation/details/widgets/sliver_image.dart';
import 'package:bloc_learning/presentation/details/widgets/tracks/tracks_list.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

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
      floatingActionButton: const _Fab(),
    );
  }
}

class _Fab extends StatelessWidget {
  const _Fab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(builder: (_, state) {
      return state.maybeWhen(
        loadedSuccessfully: (album) => album.externalUrls != null
            ? FloatingActionButton(
                child: const Icon(BootstrapIcons.spotify),
                onPressed: () async {
                  final Uri url = Uri.parse(album.externalUrls!.spotify);
                  await launchUrl(url);
                },
              )
            : Container(),
        orElse: Container.new,
      );
    });
  }
}

class _Body extends HookWidget {
  const _Body({required this.album, Key? key}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final shouldShowAppBarTitle = useState<bool>(false);

    return CustomScrollView(
      controller: scrollController
        ..addListener(() {
          shouldShowAppBarTitle.value = scrollController.offset > 400;
        }),
      slivers: [
        SliverImage(
          album: album,
          shouldShowAppBarTitle: shouldShowAppBarTitle.value,
        ),
        ArtistAndName(album: album),
        BlocBuilder<DetailsCubit, DetailsState>(builder: (_, state) {
          return state.maybeWhen(
            loadedSuccessfully: (album) => Popularity(album.popularity),
            orElse: () => const SliverToBoxAdapter(),
          );
        }),
        BlocBuilder<DetailsCubit, DetailsState>(
          builder: (_, state) {
            return state.when(
              initial: () => const LoadingIndicator.forSlivers(),
              loadingInProgress: () => const LoadingIndicator.forSlivers(),
              loadedSuccessfully: (album) {
                return TracksList(album: album);
              },
              loadedWithError: ErrorMessage.forSlivers,
            );
          },
        ),
      ],
    );
  }
}
