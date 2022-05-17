import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/data/article_service.dart';
import 'package:bloc_learning/data/articles_repository.dart';
import 'package:get_it/get_it.dart';

void setupDependencies() {
  GetIt.I.registerSingleton<ArticleService>(
    ArticleService(),
  );

  GetIt.I.registerSingleton<FakeArticleRepository>(
    FakeArticleRepository(
      GetIt.I<ArticleService>(),
    ),
  );

  GetIt.I.registerSingleton<ArticlesBloc>(
    ArticlesBloc(
      GetIt.I<FakeArticleRepository>(),
    ),
  );

  GetIt.I.registerSingleton<ArticleBloc>(
    ArticleBloc(
      GetIt.I<FakeArticleRepository>(),
    ),
  );
  GetIt.I.registerSingleton<ThemeCubit>(
    ThemeCubit(),
  );
}
