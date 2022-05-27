import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/global_blocs.dart';
import 'package:bloc_learning/resources/flavors.dart';
import 'package:bloc_learning/resources/theme/theme.dart';
import 'package:bloc_learning/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({required this.flavor, Key? key}) : super(key: key);
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    return GlobalBlocs(
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            title: 'Spotter ${flavor.toString()}',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: themeMode,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
