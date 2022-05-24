import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/resources/assets.dart';
import 'package:flutter/material.dart';

class SliverImage extends StatelessWidget {
  const SliverImage({
    required this.album,
    Key? key,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: album.id,
          child: FadeInImage(
            placeholder: const AssetImage(Assets.emptyPlaceholder),
            image: NetworkImage(album.images[1].url),
            imageErrorBuilder: (_, __, ___) {
              return Image.asset(Assets.noImage);
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
