import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';

class Popularity extends StatelessWidget {
  const Popularity(this.popularity, {Key? key}) : super(key: key);
  final int? popularity;

  @override
  Widget build(BuildContext context) {
    if (popularity == null) {
      return const SliverToBoxAdapter();
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.albumPopularity,
              style: context.theme.textTheme.labelSmall,
            ),
            FittedBox(
              child: Row(
                children: [
                  for (int i = 1; i <= 33; i++)
                    Column(
                      children: [
                        for (int j = 1; j <= 3; j++)
                          Builder(
                            builder: (context) {
                              final int index = i + j + 2 * (i - 1);

                              return Container(
                                height: 7,
                                width: 7,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: index <= popularity!
                                      ? context.theme.colorScheme.primary
                                      : context.theme.colorScheme.surfaceVariant,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
