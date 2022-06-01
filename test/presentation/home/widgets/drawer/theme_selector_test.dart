import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/home/widgets/drawer/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => themeCubit),
          ],
          child: const ThemeSelector(),
        ),
      ),
    );
  }

  group('ThemeSelector', () {
    testWidgets(
      'contains button for each theme option',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump();

        final BuildContext ctx = tester.element(find.byType(ThemeSelector));
        for (final option in ThemeMode.values) {
          expect(find.text(option.l10n(ctx).toLowerCase()), findsOneWidget);
        }
      },
    );
  });
}
