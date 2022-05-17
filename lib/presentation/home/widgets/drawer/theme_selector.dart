import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:bloc_learning/presentation/home/widgets/drawer/theme_select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Text(context.l10n.selectThemeMode),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ThemeMode.values
                    .map(
                      (m) =>
                          ThemeSelectButton(themeMode: m, isActive: state == m),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
