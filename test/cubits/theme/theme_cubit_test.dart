import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late ThemeCubit themeCubit;
  late MockStorage mockStorage;

  setUp(() {
    mockStorage = MockStorage();

    when(
      () => mockStorage.write(
        any(),
        any<dynamic>(),
      ),
    ).thenAnswer(
      (_) async {},
    );
    when<dynamic>(
      () => mockStorage.read(
        any(),
      ),
    ).thenReturn(<String, dynamic>{});

    HydratedBlocOverrides.runZoned(
      () {
        return themeCubit = ThemeCubit();
      },
      storage: mockStorage,
    );
  });

  group('Theme cubit', () {
    test('cubit has default state ThemeMode.system', () {
      expect(themeCubit.state, ThemeMode.system);
    });

    blocTest<ThemeCubit, ThemeMode>(
      'calls read on initialization',
      build: () => themeCubit,
      verify: (cubit) {
        verify<dynamic>(
          () => mockStorage.read(any()),
        ).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'initialize with saved theme',
      build: () {
        when(
          () => mockStorage.read(any()),
        ).thenAnswer((_) => {
              ThemeCubit.storageKey: ThemeMode.dark.index,
            });

        HydratedBlocOverrides.runZoned(
          () => themeCubit = ThemeCubit(),
          storage: mockStorage,
        );

        return themeCubit;
      },
      verify: (cubit) {
        expect(cubit.state, ThemeMode.dark);
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'calls write when setTheme ran',
      build: () => themeCubit,
      act: (cubit) {
        cubit.setTheme(ThemeMode.light);
      },
      verify: (cubit) {
        verify<dynamic>(
          () => mockStorage.write(any(), {ThemeCubit.storageKey: ThemeMode.light.index}),
        ).called(1);
      },
    );

    blocTest<ThemeCubit, ThemeMode>(
      'changes theme when setTheme called',
      build: () => themeCubit,
      act: (cubit) => cubit.setTheme(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'changes theme multiple times',
      build: () => themeCubit,
      act: (cubit) {
        cubit.setTheme(ThemeMode.dark);
        cubit.setTheme(ThemeMode.light);
        cubit.setTheme(ThemeMode.system);
        cubit.setTheme(ThemeMode.dark);
      },
      expect: () => [ThemeMode.dark, ThemeMode.light, ThemeMode.system, ThemeMode.dark],
      skip: 0,
    );
  });
}
