import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
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

        var mainWeatherInfo = await repository.getWeatherData(
          locality,
          country,
        ); // problem here, is that if we just search by locality, the weather api just gives Quintero in Mexico for example
        var hourByHourDetails = await repository.getWeatherHourByHourDetails(
          locality,
          country,
        );

        emit(
          WeatherLoaded(
            mainWeatherInfo: mainWeatherInfo,
            hourByHourDetails: hourByHourDetails,
          ),
        );
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
