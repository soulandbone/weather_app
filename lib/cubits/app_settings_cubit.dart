import 'package:flutter_bloc/flutter_bloc.dart';
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
          temperature: TemperatureUnits.celsius,
          precipitation: PrecipitationUnits.millimeters,
          visibility: VisibilityUnits.kilometers,
          pressure: PressureUnits.hectopascals,
          wind: WindUnits.kilometersPerHour,
        ),
      );

  void setTempUnits(TemperatureUnits temperature) {
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
