import 'dart:io';

import 'package:bloc_learning/bloc/article/article_bloc.dart';
import 'package:bloc_learning/bloc/articles/articles_bloc.dart';
import 'package:bloc_learning/data/articles_provider.dart';
import 'package:bloc_learning/presentation/article/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';
import 'package:go_router/go_router.dart';

import 'data/articles_repository.dart';
import 'presentation/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => BlocProvider(
            create: (context) =>
                ArticlesBloc(FakeArticleRepository(ArticleProvider()))
                  ..add(const LoadArticles()),
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/articles/:articleId',
          builder: (BuildContext context, GoRouterState state) => BlocProvider(
            create: (context) =>
                ArticleBloc(FakeArticleRepository(ArticleProvider())),
            child: ArticleScreen(
              id: int.parse(state.params['articleId']!),
            ),
          ),
        ),
      ],
    );
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
