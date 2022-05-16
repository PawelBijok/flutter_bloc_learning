// This file is "main.dart"
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required final int id,
    required String title,
    required String content,
    required int views,
    @Default(false) bool isFavorite,
  }) = _Article;

  factory Article.fromJson(dynamic json) => _$ArticleFromJson(json);
}
