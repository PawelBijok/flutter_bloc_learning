import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/home/widgets/drawer/theme_selector.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.settings,
              style: context.theme.textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            const ThemeSelector(),
          ],
        ),
      ),
    ));
  }
}
