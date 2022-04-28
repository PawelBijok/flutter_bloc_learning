//simulate network delay
class ArticleProvider {
  Future<String> getArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return '[{"id": 1, "title": "Article 1", "content": "Content 1", "views": 1}, {"id": 2, "title": "Article 2", "content": "Content 2", "views": 2}, {"id": 3, "title": "Article 3", "content": "Content 3", "views": 3}, {"id": 4, "title": "Article 4", "content": "Content 4", "views": 4}, {"id": 5, "title": "Article 5", "content": "Content 5", "views": 5}]';
  }
}
