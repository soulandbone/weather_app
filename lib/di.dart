import 'package:get_it/get_it.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/api_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt()),
  );
  getIt.registerFactory<WeatherCubit>(() => WeatherCubit(getIt()));
  getIt.registerFactory<AppThemeCubit>(() => AppThemeCubit());
}
