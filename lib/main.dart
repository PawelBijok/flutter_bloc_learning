import 'dart:convert';

import 'package:bloc_learning/bloc/articles_bloc.dart';
import 'package:bloc_learning/models/article/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/articles_repository.dart';

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
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, ArticlesState state) {
          if (state is ArticlesInitial || state is ArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ArticlesLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final Article article = state.articles[index];
                return ListTile(
                  title: Text(article.title),
                );
              },
            );
          }

          return Center(
            child: Text('We do not support "$state" state yes'),
          );
        },
      ),
    );
  }
}
