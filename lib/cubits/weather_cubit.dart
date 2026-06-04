import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/geo_location_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.repository, this.geolocationService)
    : super(WeatherInitial());

  final WeatherRepository repository;
  final GeolocationService geolocationService;

  Future<void> fetchLocationAndWeather() async {
    emit(WeatherLoading());
    print("The time now is ${DateTime.now().toIso8601String()}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastRequest', DateTime.now().toIso8601String());

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
        ); // problem here, is that if we just search by locality, the weather api just gives Quintero in Mexico for example

        emit(WeatherLoaded(weatherResponse: weatherResponse));
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> fetchLocationAnd7DaysForecast() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var timeNow = DateTime.now();
    var lastConnectionString = prefs.getString('lastRequest');

    if (lastConnectionString != null) {
      var lastConnectionDate = DateTime.parse(lastConnectionString);
      var difference = timeNow.difference(lastConnectionDate);

      String city;
      String country;

      if (difference.inHours < 1) {
        city = prefs.getString('lastLocationCity')!;
        country = prefs.getString('lastLocationCountry')!;

        var forecastResponse = await repository.getSevenDaysForecast(
          city,
          country,
        );
        emit(ForecastLoaded(forecastResponse: forecastResponse));
      }
    }
  }
}
