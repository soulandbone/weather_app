import 'package:get_it/get_it.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/helpers/units_mapper.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/geo_location_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  getIt.registerLazySingleton<GeolocationService>(
    () => GeolocationService(),
  ); //
  getIt.registerLazySingleton<UnitsMapper>(() => UnitsMapper()); //
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt()),
  );
  getIt.registerFactory<WeatherCubit>(
    () => WeatherCubit(getIt<WeatherRepository>(), getIt<GeolocationService>()),
  );
  getIt.registerFactory<AppThemeCubit>(() => AppThemeCubit());
  getIt.registerFactory<AppSettingsCubit>(() => AppSettingsCubit(getIt()));
}
