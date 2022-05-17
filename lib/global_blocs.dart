import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class GlobalBlocs extends StatelessWidget {
  const GlobalBlocs({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetIt.I<ArticlesBloc>()..add(const LoadArticles()),
        ),
        BlocProvider(
          create: (context) => GetIt.I<ArticleBloc>(),
        ),
        BlocProvider(create: (context) => GetIt.I<ThemeCubit>()),
      ],
      child: child,
    );
  }
}
