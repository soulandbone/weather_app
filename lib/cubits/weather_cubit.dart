import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
    List<Placemark> placemarks = [];

    try {
      Position? position = await geolocationService.getCurrentPosition();

      if (position == null) {
        emit(WeatherError('Location cannot be retrieved at this moment'));
      } else {
        placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
      }

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String locality = place.locality ?? 'Unknown locality';

        try {
          var mainWeatherInfo = await repository.getWeatherData(locality);
          var hourByHourDetails = await repository.getWeatherHourByHourDetails(
            locality,
          );

          emit(
            WeatherLoaded(
              mainWeatherInfo: mainWeatherInfo,
              hourByHourDetails: hourByHourDetails,
            ),
          );
        } catch (e) {
          emit(WeatherError(e.toString()));
        }
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
