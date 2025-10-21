import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/app_theme_state.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/di.dart';
import 'package:weather_app/presentation/screens/home_page.dart';
import 'package:weather_app/theming/app_theme.dart';

void main() {
  setup();
  runApp(const BlocProviders());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<WeatherCubit>()),
        BlocProvider(create: (_) => getIt<AppThemeCubit>()),
        BlocProvider(create: (_) => getIt<AppSettingsCubit>()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppThemeCubit>().state;

    return MaterialApp(
      theme: appState.isDark ? AppTheme.dark : AppTheme.light,
      home: HomePage(),
    );
  }
}
