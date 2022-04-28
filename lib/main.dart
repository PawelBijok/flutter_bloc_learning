import 'dart:convert';

import 'package:bloc_learning/bloc/articles_bloc.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/articles_repository.dart';
import 'presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            ArticlesBloc(ArticleRepository())..add(GetArticles()),
        child: const HomeScreen(),
      ),
    );
  }
}
