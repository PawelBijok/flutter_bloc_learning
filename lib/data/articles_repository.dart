import 'dart:convert';

import 'package:bloc_learning/data/articles_provider.dart';

import '../models/article/article.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
  Future<Article> getArticleByID(int id);
}

class FakeArticleRepository implements ArticleRepository {
  final ArticleProvider articleProvider;

  FakeArticleRepository(this.articleProvider);

  @override
  Future<List<Article>> getArticles() async {
    try {
      final String articlesString = await articleProvider.getArticles();
      final List<dynamic> articles = json.decode(articlesString);
      return articles.map((article) => Article.fromJson(article)).toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Article> getArticleByID(int id) async {
    try {
      final String articleString = await articleProvider.getArticleByID(id);
      final List<dynamic> article = json.decode(articleString);
      return Article.fromJson(article.first);
    } catch (_) {
      rethrow;
    }
  }
}
