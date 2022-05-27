import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/resources/assets.dart';
import 'package:flutter/material.dart';

class LoadedContent extends StatelessWidget {
  const LoadedContent({required this.album, Key? key}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(album.name),
            background: FadeInImage(
              placeholder: const AssetImage(Assets.emptyPlaceholder),
              image: NetworkImage(album.images[1].url),
              imageErrorBuilder: (_, __, ___) {
                return Image.asset(Assets.noImage);
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
