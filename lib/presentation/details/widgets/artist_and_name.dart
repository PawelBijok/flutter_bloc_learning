import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:flutter/material.dart';

class ArtistAndName extends StatelessWidget {
  const ArtistAndName({
    required this.album,
    Key? key,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (album.artists != null && album.artists!.isNotEmpty)
              Text(
                album.artists![0].name,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Text(
              album.name,
              style: theme.textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
