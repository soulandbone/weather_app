import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_lists.dart';
import 'package:weather_app/constants/app_maps.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/settings_state.dart';
import 'package:weather_app/models/units_settings.dart';
import 'package:weather_app/presentation/widgets/settings_menu_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AppSettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              SettingsMenuTile(
                unitSetting: UnitsSettings(
                  title: AppStrings.kTemperatureLabel,
                  currentSelection:
                      context.watch<AppSettingsCubit>().state.temperature,
                  onSelected: (temperature) {
                    context.read<AppSettingsCubit>().setTempUnits(temperature);
                  },
                  unitOptions: AppLists.kTemperatureOptions,
                  unitsMap: AppMaps.kTemperatureMappings,
                ),
              ),
              SettingsMenuTile(
                unitSetting: UnitsSettings(
                  title: AppStrings.kPressureLabel,
                  unitOptions: AppLists.kPressureOptions,
                  onSelected: (pressure) {
                    context.read<AppSettingsCubit>().setPressureUnits(pressure);
                  },
                  currentSelection:
                      context.watch<AppSettingsCubit>().state.pressure,
                  unitsMap: AppMaps.kPressureMappings,
                ),
              ),
              SettingsMenuTile(
                unitSetting: UnitsSettings(
                  title: AppStrings.kWindLabel,
                  unitOptions: AppLists.kWindOptions,
                  onSelected: (wind) {
                    context.read<AppSettingsCubit>().setWindUnits(wind);
                  },
                  currentSelection:
                      context.watch<AppSettingsCubit>().state.wind,
                  unitsMap: AppMaps.kWindMappings,
                ),
              ),
              SettingsMenuTile(
                unitSetting: UnitsSettings(
                  title: AppStrings.kPrecipitationlabel,
                  unitOptions: AppLists.kPrecipitationOptions,
                  onSelected: (precipitation) {
                    context.read<AppSettingsCubit>().setPrecipitationUnits(
                      precipitation,
                    );
                  },
                  currentSelection:
                      context.watch<AppSettingsCubit>().state.precipitation,
                  unitsMap: AppMaps.kPrecipitationMappings,
                ),
              ),
              SettingsMenuTile(
                unitSetting: UnitsSettings(
                  title: AppStrings.kVisibilityLabel,
                  unitOptions: AppLists.kVisibilityOptions,
                  onSelected: (visibility) {
                    context.read<AppSettingsCubit>().setVisibilityUnits(
                      visibility,
                    );
                  },
                  currentSelection:
                      context.watch<AppSettingsCubit>().state.visibility,
                  unitsMap: AppMaps.kVisibilityMappings,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
