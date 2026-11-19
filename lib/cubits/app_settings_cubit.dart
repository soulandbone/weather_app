import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/app_settings_state.dart';
import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';

class AppSettingsCubit extends Cubit<SettingsState> {
  AppSettingsCubit() : super(SettingsLoading()) {
    _loadState(); // gets all the info from sharedPreferences, and then sets state with the corresponding values
  }

  Future<void> _loadState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCelsius = prefs.getBool('isCelsius') ?? true;
    bool isMillimeters = prefs.getBool('isMillimeters') ?? true;
    bool isKilometers = prefs.getBool('isKilometers') ?? true;
    int pressureUnits = prefs.getInt('pressureUnits') ?? 1;
    int windUnits = prefs.getInt('windUnits') ?? 1;

    emit(
      SettingsLoaded(
        precipitation:
            isMillimeters
                ? PrecipitationUnits.millimeters
                : PrecipitationUnits.inches,
        visibility:
            isKilometers ? VisibilityUnits.kilometers : VisibilityUnits.miles,
        pressure: PressureUnits.pressureUnitsFromInt(pressureUnits),
        wind: WindUnits.windUnitsFromInt(windUnits),
        temperature:
            isCelsius ? TemperatureUnits.celsius : TemperatureUnits.fahrenheit,
      ),
    );
  }

  Future<void> setTempUnits(TemperatureUnits temperature) async {
    final current = state;

    if (current is! SettingsLoaded) return;

    emit(current.copyWith(temperature: temperature));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCelsius', TemperatureUnits.celsius == temperature);
  }

  Future<void> setPrecipitationUnits(PrecipitationUnits precipitation) async {
    final current = state;
    if (current is! SettingsLoaded) return;

    emit(current.copyWith(precipitation: precipitation));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isMillimeters',
      PrecipitationUnits.millimeters == precipitation,
    );
  }

  Future<void> setVisibilityUnits(VisibilityUnits visibility) async {
    final current = state;
    if (current is! SettingsLoaded) return;

    emit(current.copyWith(visibility: visibility));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isKilometers',
      VisibilityUnits.kilometers == visibility,
    );
  }

  Future<void> setPressureUnits(PressureUnits pressure) async {
    final current = state;
    if (current is! SettingsLoaded) return;

    emit(current.copyWith(pressure: pressure));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pressureUnits', pressure.selection);
  }

  Future<void> setWindUnits(WindUnits wind) async {
    final current = state;
    if (current is! SettingsLoaded) return;

    emit(current.copyWith(wind: wind));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('windUnits', wind.selection);
  }
}
