import 'package:bloc_learning/models/article/article.dart';
import 'package:bloc_learning/presentation/home/widgets/article_item.dart';
import 'package:flutter/material.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({required this.articles, Key? key}) : super(key: key);
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final Article article = articles[index];

        return ArticleItem(article);
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
    );
  }
}
