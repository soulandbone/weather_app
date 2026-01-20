import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/settings_state.dart';
import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class AppSettingsCubit extends Cubit<SettingsState> {
  AppSettingsCubit()
    : super(
        SettingsState(
          precipitation: PrecipitationUnits.millimeters,
          visibility: VisibilityUnits.kilometers,
          pressure: PressureUnits.hectopascals,
          wind: WindUnits.kilometersPerHour,
          temperature: TemperatureUnits.celsius,
        ),
      ) {
    _loadState();
  }

  Future<void> _loadState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCelsius = prefs.getBool('isCelsius') ?? true;

    emit(
      SettingsState(
        precipitation: PrecipitationUnits.millimeters,
        visibility: VisibilityUnits.kilometers,
        pressure: PressureUnits.hectopascals,
        wind: WindUnits.kilometersPerHour,
        temperature:
            isCelsius ? TemperatureUnits.celsius : TemperatureUnits.fahrenheit,
      ),
    );
  }

  Future<void> setTempUnits(TemperatureUnits temperature) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCelsius', TemperatureUnits.celsius == temperature);
    emit(state.copyWith(temperature: temperature));
  }

  void setPrecipitationUnits(PrecipitationUnits precipitation) {
    emit(state.copyWith(precipitation: precipitation));
  }

  void setVisibilityUnits(VisibilityUnits visibility) {
    emit(state.copyWith(visibility: visibility));
  }

  void setPressureUnits(PressureUnits pressure) {
    emit(state.copyWith(pressure: pressure));
  }

  void setWindUnits(WindUnits wind) {
    emit(state.copyWith(wind: wind));
  }
}
