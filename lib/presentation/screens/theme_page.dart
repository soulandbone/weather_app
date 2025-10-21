import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/app_theme_state.dart';
import 'package:weather_app/theming/app_theme.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text('Dark Theme '),

                    value: context.read<AppThemeCubit>().state is AppThemeDark,
                    onChanged: (value) {
                      context.read<AppThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
