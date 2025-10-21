import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeDark());

  void toggleTheme() {
    if (state is AppThemeDark) {
      emit(AppThemeLight());
    } else {
      emit(AppThemeDark());
    }
  }
}
