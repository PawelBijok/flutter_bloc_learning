import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/details/widgets/tracks/track_list_item.dart';
import 'package:flutter/material.dart';

class TracksList extends StatelessWidget {
  const TracksList({required this.album, Key? key}) : super(key: key);

  final Album album;
  @override
  Widget build(BuildContext context) {
    return album.tracks != null
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => TrackListItem(track: album.tracks!.items[i]),
              childCount: album.totalTracks,
            ),
          )
        : SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Text(
                context.l10n.tracksNotFound,
                style: context.theme.textTheme.titleLarge,
              ),
            ),
          );
  }
}
