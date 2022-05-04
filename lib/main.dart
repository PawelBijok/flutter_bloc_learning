import 'dart:io';

import 'package:bloc_learning/presentation/article/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beamer/beamer.dart';

import 'bloc/article/article_bloc.dart';
import 'bloc/articles/articles_bloc.dart';
import 'data/articles_repository.dart';
import 'presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          '/': (context, state, data) => BlocProvider(
                create: (context) =>
                    ArticlesBloc(FakeArticleRepository())..add(LoadArticles()),
                child: const HomeScreen(),
              ),
          '/articles/:articleId': (context, state, ctx) {
            // Take the path parameter of interest from BeamState
            final articleId = state.pathParameters['articleId']!;

            // Use BeamPage to define custom behavior
            return BeamPage(
              key: ValueKey('article-$articleId'),
              title: 'An Article #$articleId',
              popToNamed: '/',
              type: Platform.isIOS
                  ? BeamPageType.cupertino
                  : BeamPageType.material,
              child: BlocProvider(
                create: (context) => ArticleBloc(FakeArticleRepository()),
                child: ArticleScreen(
                  id: int.parse(articleId),
                ),
              ),
            );
          }
        },
      ),
    );
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
