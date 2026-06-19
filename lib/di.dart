import 'package:get_it/get_it.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_theme_cubit.dart';
import 'package:weather_app/cubits/weather_cubit.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/geo_location_service.dart';
import 'package:weather_app/services/http_client.dart';

import 'package:weather_app/services/http_client_http.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<HttpClient>(() => HttpClientHttp());

  getIt.registerLazySingleton<ApiService>(
    () => ApiServiceImpl(getIt<HttpClient>()),
  );
  getIt.registerLazySingleton<GeoLocationService>(
    () => GeoLocationServiceImpl(),
  ); //

  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt<ApiService>()),
  );
  getIt.registerFactory<WeatherCubit>(
    () => WeatherCubit(getIt<WeatherRepository>(), getIt<GeoLocationService>()),
  );
  getIt.registerFactory<AppThemeCubit>(() => AppThemeCubit());
  getIt.registerFactory<AppSettingsCubit>(() => AppSettingsCubit());
}
