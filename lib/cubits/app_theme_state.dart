class AppThemeState {
  const AppThemeState();
}

class AppThemeLoading extends AppThemeState {}

class AppThemeLoaded extends AppThemeState {
  AppThemeLoaded({required this.isDark});

  final bool isDark;
}
