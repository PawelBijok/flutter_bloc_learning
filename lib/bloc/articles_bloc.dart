import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitial()) {
    on<ArticlesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
