import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push('/articles/${article.id}');
      },
      leading: IconButton(
        key: const Key('test__favorite-button'),
        icon: Icon(
          article.isFavorite ? Icons.bookmark : Icons.bookmark_outline,
        ),
        onPressed: () {
          context.read<ArticlesBloc>().add(ToggleFavouriteArticle(article.id));
        },
      ),
      title: Text(article.title),
      subtitle: Text(article.content),
      trailing: article.views > 0
          ? Row(
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
            )
          : null,
    );
  }
}
