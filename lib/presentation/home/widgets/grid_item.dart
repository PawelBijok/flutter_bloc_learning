import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/details/details_screen.dart';
import 'package:bloc_learning/resources/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridItem extends StatelessWidget {
  const GridItem({required this.album, Key? key}) : super(key: key);
  final Album album;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(DetailsScreen.generateRoute(album.id), extra: album);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Hero(
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
              const SizedBox(height: 10),
              Text(
                album.name,
                style: context.theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                album.artists?.first.name ?? context.l10n.unknownArtist,
                style: context.theme.textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
