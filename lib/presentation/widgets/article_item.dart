import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/articles/articles_bloc.dart';
import '../../models/article/article.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  const ArticleItem(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          onTap: () {
            Beamer.of(context)
                .beamToNamed('/articles/${article.id}', data: context);
          },
          leading: IconButton(
              icon: Icon(
                  article.isFavorite ? Icons.bookmark : Icons.bookmark_outline),
              onPressed: () {
                context
                    .read<ArticlesBloc>()
                    .add(ToggleFavouriteArticle(article.id));
              }),
          title: Text(article.title),
          subtitle: Text(article.content),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.visibility,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(article.views.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
