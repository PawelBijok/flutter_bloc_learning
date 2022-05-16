import 'package:bloc_learning/app.dart';
import 'package:bloc_learning/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () {
      setupDependencies();
      return runApp(const App());
    },
    storage: storage,
  );
}
