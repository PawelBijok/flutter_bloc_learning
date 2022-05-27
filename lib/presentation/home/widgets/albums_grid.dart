import 'package:bloc_learning/cubits/home/home_cubit.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/core/widgets/loading_indicator.dart';
import 'package:bloc_learning/presentation/home/widgets/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlbumsGrid extends HookWidget {
  const AlbumsGrid({required this.albums, Key? key}) : super(key: key);
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    const sliverDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 3,
      childAspectRatio: 0.7,
    );

    final scrollController = useScrollController();
    final loadingState = useState<bool>(false);

    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refresh(),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: GridView.builder(
              controller: scrollController
                ..addListener(() {
                  if (scrollController.offset == scrollController.position.maxScrollExtent) {
                    loadingState.value = true;
                    context.read<HomeCubit>().loadMoreAlbums().then((_) => loadingState.value = false);
                  }
                }),
              gridDelegate: sliverDelegate,
              itemCount: albums.length,
              itemBuilder: (_, i) => GridItem(album: albums[i]),
            ),
          ),
          if (loadingState.value) const LoadingIndicator.floatingBottom(),
        ],
      ),
    );
  }
}
