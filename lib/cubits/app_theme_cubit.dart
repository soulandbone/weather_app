import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeState(isDark: false));

  void toggleTheme() {
    emit(AppThemeState(isDark: !state.isDark));
  }
}
