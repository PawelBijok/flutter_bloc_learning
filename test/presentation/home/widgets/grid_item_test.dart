import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/models/album/album.dart';
import 'package:bloc_learning/presentation/home/widgets/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fakes/albums_lists.dart';

void main() {
  setUp(() {});

  Widget createWidgetUnderTest(Album album) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: GridItem(
          album: album,
        ),
      ),
    );
  }

  group('GridItem', () {
    testWidgets(
      'displays album title',
      (WidgetTester tester) async {
        final album = fakeAlbumsList[0];
        await tester.pumpWidget(createWidgetUnderTest(album));
        await tester.pump();
        expect(find.text(album.name), findsOneWidget);
      },
    );
    testWidgets(
      'displays album artist',
      (WidgetTester tester) async {
        final album = fakeAlbumsList[0];
        await tester.pumpWidget(createWidgetUnderTest(album));
        await tester.pump();
        expect(find.text(album.artists![0].name), findsOneWidget);
      },
    );
    testWidgets(
      'displays unknown artist when artist is unknown',
      (WidgetTester tester) async {
        final album = fakeAlbumsListNoArtists[0];
        await tester.pumpWidget(createWidgetUnderTest(album));
        await tester.pump();
        final BuildContext ctx = tester.element(find.byType(GridItem));

        expect(find.text(ctx.l10n.unknownArtist), findsOneWidget);
      },
    );
  });
}
