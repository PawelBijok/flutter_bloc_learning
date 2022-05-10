import 'package:bloc_learning/global_blocs.dart';
import 'package:bloc_learning/presentation/article/article_screen.dart';
import 'package:bloc_learning/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: HomeScreen.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          path: ArticleScreen.routeName,
          builder: (BuildContext context, GoRouterState state) => ArticleScreen(
            id: int.parse(state.params['articleId']!),
          ),
        ),
      ],
    );

    return GlobalBlocs(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'BLoC Learning',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
