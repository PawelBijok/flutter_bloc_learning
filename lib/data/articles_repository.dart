import 'dart:convert';

import 'package:bloc_learning/data/article_service.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:logger/logger.dart';

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
  Future<Article> getArticleByID(int id);
}

class FakeArticleRepository implements ArticleRepository {
  FakeArticleRepository(this.articleService) {
    logger.i('FakeArticleRepository created');
  }
  final ArticleService articleService;
  final logger = Logger(
    printer: PrettyPrinter(errorMethodCount: 0, methodCount: 0),
  );

  @override
  Future<List<Article>> getArticles() async {
    try {
      final String articlesString = await articleService.getArticles();
      final List<dynamic> articles = json.decode(articlesString);

      return articles.map<Article>(Article.fromJson).toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Article> getArticleByID(int id) async {
    try {
      final String articleString = await articleService.getArticleByID(id);
      final List<dynamic> article = json.decode(articleString);

      return Article.fromJson(article.first);
    } catch (_) {
      rethrow;
    }
  }
}
