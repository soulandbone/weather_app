import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

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

                    value: state.isDark,
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
