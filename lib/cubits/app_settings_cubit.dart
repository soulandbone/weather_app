import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/settings_state.dart';

class AppSettingsCubit extends Cubit<SettingsState> {
  AppSettingsCubit()
    : super(
        SettingsState(
          isTempCelsius: true,
          isPrecipitationMillimeters: true,
          isVisibilityKilometers: true,
          pressure: Pressure.hectopascals,
          windOptions: WindOptions.feetPerSecond,
        ),
      );

  void setTempUnits(bool isTempCelsius) {
    emit(state.copyWith(isTempCelsius: isTempCelsius));
  }

  void setPrecipitationUnits(bool isPrecipitationMillimeters) {
    emit(
      state.copyWith(isPrecipitationMillimeters: isPrecipitationMillimeters),
    );
  }

  void setVisibilityUnits(bool isVisibilityKilometers) {
    emit(state.copyWith(isVisibilityKilometers: isVisibilityKilometers));
  }

  void setPressureUnits(Pressure pressure) {
    //TODO: Test
    Pressure.hectopascals;
    emit(state.copyWith());
  }

  void setWindUnits(WindOptions windOptions) {
    //TODO:
    emit(state.copyWith());
  }
}
