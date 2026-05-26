import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeLoading()) {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    final currentState = state;
    if (currentState is AppThemeLoaded) {
      final newIsDark = !currentState.isDark;
      await _saveTheme(newIsDark);
      emit(AppThemeLoaded(isDark: newIsDark));
    }
  }

  void restorePreviousState(AppThemeLoaded previous) {
    emit(previous);
  }

  // to save the newTheme into the shared preferences
  Future<void> _saveTheme(bool isDark) async {
    final currentState = state;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(
        'isDark',
        isDark,
      ); //waits to see how it resolves potentially stopping if resolves to an error
    } catch (e) {
      if (currentState is AppThemeLoaded) {
        emit(AppThemeError(message: e.toString(), previous: currentState));
      }
    }
  }

  //to get the current Theme from the shared preferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDark');
      emit(AppThemeLoaded(isDark: isDark ?? false));
    } catch (e) {
      emit(
        AppThemeError(
          message: e.toString(),
          previous: AppThemeLoaded(isDark: false),
        ),
      );
    }
  }
}
