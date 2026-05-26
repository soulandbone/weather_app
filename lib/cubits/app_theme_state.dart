class AppThemeState {
  const AppThemeState();
}

class AppThemeLoading extends AppThemeState {}

class AppThemeLoaded extends AppThemeState {
  AppThemeLoaded({required this.isDark});

  final bool isDark;
}

class AppThemeError extends AppThemeState {
  AppThemeError({required this.message, required this.previous});

  final String message;
  final AppThemeLoaded previous;
}
