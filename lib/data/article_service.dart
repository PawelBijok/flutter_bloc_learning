//simulate network delay
import 'dart:math';
import 'package:bloc_learning/exceptions/network_exception.dart';
import 'package:faker/faker.dart';

class ArticleService {
  bool throwError() {
    // returns true 40% of a time
    return Random().nextDouble() <= 0.1;
  }

  Future<String> getArticles() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (throwError()) {
      throw NetworkException(
        'Something went wrong 🤯 Try again you have 90% chance to succeed 🙃',
      );
    }

    return '[{"id": 1, "title": "Article 1", "content": "Content 1", "views": 0}, {"id": 2, "title": "Article 2", "content": "Content 2", "views": 2}, {"id": 3, "title": "Article 3", "content": "Content 3", "views": 3}, {"id": 4, "title": "Article 4", "content": "Content 4", "views": 4}, {"id": 5, "title": "Article 5", "content": "Content 5", "views": 5}]';
  }

  Future<String> getArticleByID(int id) async {
    final faker = Faker();
    final String lorem = (faker.lorem.words(120)).join(' ');

    await Future.delayed(const Duration(milliseconds: 500));
    if (throwError()) {
      throw NetworkException(
        'Something went wrong 🤯 Try again you have 90% chance to succeed 🙃',
      );
    }

    return '[{"id": $id, "title": "Article $id", "content": "Content $id, $lorem ", "views": $id}]';
  }
}
