import 'dart:convert';

import 'package:bloc_learning/data/articles_provider.dart';

import '../models/article/article.dart';

class ArticleRepository {
  final ArticleProvider articleProvider = ArticleProvider();

  Future<List<Article>> getArticles() async {
    final String articlesString = await articleProvider.getArticles();
    final List<dynamic> articles = json.decode(articlesString);
    return articles.map((article) => Article.fromJson(article)).toList();
  }
}
