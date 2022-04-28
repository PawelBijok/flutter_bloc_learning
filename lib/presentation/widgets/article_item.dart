import 'package:flutter/material.dart';

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
          title: Text(article.title),
          subtitle: Text(article.content),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.visibility,
              ),
              SizedBox(
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
