part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class GetArticles extends ArticlesEvent {}

class GetArticleByID extends ArticlesEvent {
  final int id;

  GetArticleByID(this.id);
}

//TODO: Write an event to add new event 
