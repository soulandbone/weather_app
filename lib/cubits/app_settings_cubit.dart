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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCelsius', TemperatureUnits.celsius == temperature);

    emit((state as SettingsLoaded).copyWith(temperature: temperature));
  }

  Future<void> setPrecipitationUnits(PrecipitationUnits precipitation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isMillimeters',
      PrecipitationUnits.millimeters == precipitation,
    );
    emit((state as SettingsLoaded).copyWith(precipitation: precipitation));
  }

  Future<void> setVisibilityUnits(VisibilityUnits visibility) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      'isKilometers',
      VisibilityUnits.kilometers == visibility,
    );
    emit((state as SettingsLoaded).copyWith(visibility: visibility));
  }

  Future<void> setPressureUnits(PressureUnits pressure) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('pressureUnits', pressure.selection);

    emit((state as SettingsLoaded).copyWith(pressure: pressure));
  }

  Future<void> setWindUnits(WindUnits wind) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('windUnits', wind.selection);
    emit((state as SettingsLoaded).copyWith(wind: wind));
  }
}
