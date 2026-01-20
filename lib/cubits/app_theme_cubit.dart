import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeLoading()) {
    _loadTheme();
  }

  void toggleTheme() {
    if (state is AppThemeLoaded) {
      final currentState = state as AppThemeLoaded;
      var isDark = !currentState.isDark;
      _saveTheme(isDark);
      emit(AppThemeLoaded(isDark: isDark));
    }
  }

  // to save the newTheme into the shared preferences
  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  //to get the current Theme from the shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark');
    emit(AppThemeLoaded(isDark: isDark ?? false));
  }
}
