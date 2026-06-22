import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/geo_location_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.repository, this.geolocationService)
    : super(WeatherInitial());

  final WeatherRepository repository;
  final GeoLocationService geolocationService;

  Future<void> fetchLocationAndWeather() async {
    emit(WeatherLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final position = await geolocationService.getCurrentPosition();

      if (position == null) {
        emit(WeatherError('Location cannot be retrieved at this moment'));
        return;
      }

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      // print("Placemarks are $placemarks");
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // print("place is ${placemarks.first}");
        final locality = place.locality ?? 'Unknown locality';
        final country = place.country ?? 'Unknown country';
        await prefs.setString('lastLocationCity', locality);
        await prefs.setString('lastLocationCountry', country);

        var weatherResponse = await repository.getWeatherData(
          locality,
          country,
        );

        // problem here, is that if we just search by locality, the weather api just gives Quintero in Mexico for example

        emit(
          WeatherLoaded(weatherResponse: weatherResponse),
        ); //Weatherloaded defaults isForecastLoading to true

        var forecastResponse = await repository.getThreeDaysForecast(
          locality,
          country,
        );

        emit(
          (state as WeatherLoaded).copyWith(
            forecastResponse: forecastResponse,
            isForecastLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(WeatherError(AppStrings.kErrorSomethingWentWrong));
    }
  }
}
