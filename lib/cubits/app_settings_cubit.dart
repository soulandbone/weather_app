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
    bool isMillimeters = prefs.getBool('isMillimeters') ?? true;
    bool isKilometers = prefs.getBool('isKilometers') ?? true;
    int pressureUnits = prefs.getInt('pressureUnits') ?? 1;
    int windUnits = prefs.getInt('windUnits') ?? 1;

    emit(
      SettingsState(
        precipitation:
            isMillimeters
                ? PrecipitationUnits.millimeters
                : PrecipitationUnits.inches,
        visibility:
            isKilometers ? VisibilityUnits.kilometers : VisibilityUnits.miles,
        pressure: pressureUnitsFromInt(pressureUnits),
        wind: windUnitsFromInt(windUnits),
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

  Future<void> setPrecipitationUnits(PrecipitationUnits precipitation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isMillimeters',
      PrecipitationUnits.millimeters == precipitation,
    );
    emit(state.copyWith(precipitation: precipitation));
  }

  Future<void> setVisibilityUnits(VisibilityUnits visibility) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isKilometers',
      VisibilityUnits.kilometers == visibility,
    );
    emit(state.copyWith(visibility: visibility));
  }

  Future<void> setPressureUnits(PressureUnits pressure) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('pressureUnits', intFromPressureUnits(pressure));

    emit(state.copyWith(pressure: pressure));
  }

  Future<void> setWindUnits(WindUnits wind) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('windUnits', intFromWindUnits(wind));
    emit(state.copyWith(wind: wind));
  }
}

/* ------------------------- HELPER FUNCTIONS  ------------------------------------------- */

int intFromPressureUnits(PressureUnits units) {
  switch (units) {
    case PressureUnits.hectopascals:
      return 1;
    case PressureUnits.inchesOfMercury:
      return 2;
    case PressureUnits.millimetersOfMercury:
      return 3;
  }
}

PressureUnits pressureUnitsFromInt(int number) {
  switch (number) {
    case 1:
      return PressureUnits.hectopascals;
    case 2:
      return PressureUnits.inchesOfMercury;
    case 3:
      return PressureUnits.millimetersOfMercury;
    default:
      return PressureUnits.hectopascals;
  }
}

int intFromWindUnits(WindUnits units) {
  switch (units) {
    case WindUnits.kilometersPerHour:
      return 1;
    case WindUnits.metersPerSecond:
      return 2;
    case WindUnits.milesPerHour:
      return 3;
    case WindUnits.feetPerSecond:
      return 4;
    case WindUnits.nauticalMilesPerHour:
      return 5;
  }
}

WindUnits windUnitsFromInt(int number) {
  switch (number) {
    case 1:
      return WindUnits.kilometersPerHour;
    case 2:
      return WindUnits.metersPerSecond;
    case 3:
      return WindUnits.milesPerHour;
    case 4:
      return WindUnits.feetPerSecond;
    case 5:
      return WindUnits.nauticalMilesPerHour;
    default:
      return WindUnits.kilometersPerHour;
  }
}
