import 'package:flutter/material.dart';

import '../../models/article/article.dart';
import 'article_item.dart';

class ArticelsList extends StatelessWidget {
  final List<Article> articles;
  const ArticelsList({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final Article article = articles[index];
        return ArticleItem(article);
      },
    );
  }
}
