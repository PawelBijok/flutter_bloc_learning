part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class GetArticles extends ArticlesEvent {}

class GetArticlByID extends ArticlesEvent {
  final int id;

  GetArticlByID(this.id);
}

//TODO: Write an event to add new event 
