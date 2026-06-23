import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppThemeCubit, AppThemeState>(
      listener: (context, state) {
        if (state is AppThemeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              action: SnackBarAction(
                label: AppStrings.kRetry,
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              ),
            ),
          );
          context.read<AppThemeCubit>().restorePreviousState(state.previous);
        }
      },
      child: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          if (state is AppThemeLoaded) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text(AppStrings.kDarkTheme),

                      value: state.isDark,
                      onChanged: (_) {
                        context.read<AppThemeCubit>().toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
