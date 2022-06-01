import 'package:bloc_learning/cubits/theme/theme_cubit.dart';
import 'package:bloc_learning/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSelectButton extends StatelessWidget {
  const ThemeSelectButton({
    required this.themeMode,
    required this.isActive,
    Key? key,
  }) : super(key: key);
  final ThemeMode themeMode;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<ThemeCubit>().setTheme(themeMode),
        child: Container(
          color: isActive ? colorScheme.primary : colorScheme.primaryContainer,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                themeMode.l10n(context).toLowerCase(),
                style: context.theme.textTheme.titleSmall!.copyWith(
                  color: isActive ? colorScheme.onPrimary : colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
