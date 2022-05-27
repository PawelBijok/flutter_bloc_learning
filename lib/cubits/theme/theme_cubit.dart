import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  static const String storageKey = 'users_theme_mode';

  void setTheme(ThemeMode theme) => emit(theme);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) => ThemeMode.values[json[storageKey] as int];

  @override
  Map<String, dynamic> toJson(ThemeMode state) => {storageKey: state.index};
}
