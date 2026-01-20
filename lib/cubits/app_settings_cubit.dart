import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubits/settings_state.dart';
import 'package:weather_app/enums/precipitation_units.dart';
import 'package:weather_app/enums/pressure_units.dart';
import 'package:weather_app/enums/temperature_units.dart';
import 'package:weather_app/enums/visibility_units.dart';
import 'package:weather_app/enums/wind_units.dart';
import 'package:weather_app/helpers/units_mapper.dart';

class AppSettingsCubit extends Cubit<SettingsState> {
  AppSettingsCubit(this.mappers)
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

  final UnitsMapper mappers;

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
        pressure: mappers.pressureUnitsFromInt(pressureUnits),
        wind: mappers.windUnitsFromInt(windUnits),
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

    await prefs.setInt('pressureUnits', mappers.intFromPressureUnits(pressure));

    emit(state.copyWith(pressure: pressure));
  }

  Future<void> setWindUnits(WindUnits wind) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('windUnits', mappers.intFromWindUnits(wind));
    emit(state.copyWith(wind: wind));
  }
}
