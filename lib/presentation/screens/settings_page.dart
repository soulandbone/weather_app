import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_lists.dart';
import 'package:weather_app/constants/app_maps.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_settings_state.dart';
import 'package:weather_app/models/units_settings.dart';
import 'package:weather_app/presentation/widgets/settings_menu_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoaded = context.select(
      (AppSettingsCubit cubit) => cubit.state is SettingsLoaded,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Units')),
      body:
          isLoaded
              ? const Column(
                children: [
                  _TemperatureTile(),
                  _PressureTile(),
                  _WindTile(),
                  _PrecipitationTile(),
                  _VisibilityTile(),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}

class _TemperatureTile extends StatelessWidget {
  const _TemperatureTile();

  @override
  Widget build(BuildContext context) {
    final temperature = context.select(
      (AppSettingsCubit cubit) => switch (cubit.state) {
        SettingsLoaded settingsLoaded => settingsLoaded.temperature,
        _ => null,
      },
    );

    if (temperature == null) return const SizedBox.shrink();

    return SettingsMenuTile(
      unitSetting: UnitsSettings(
        title: AppStrings.kTemperatureLabel,
        currentSelection: temperature,
        onSelected: (selected) {
          context.read<AppSettingsCubit>().setTempUnits(selected);
        },
        unitOptions: AppLists.kTemperatureOptions,
        unitsMap: AppMaps.kTemperatureMappings,
      ),
    );
  }
}

class _WindTile extends StatelessWidget {
  const _WindTile();
  @override
  Widget build(BuildContext context) {
    final wind = context.select(
      (AppSettingsCubit cubit) => switch (cubit.state) {
        SettingsLoaded settingsLoaded => settingsLoaded.wind,
        _ => null,
      },
    );
    if (wind == null) return const SizedBox.shrink();
    return SettingsMenuTile(
      unitSetting: UnitsSettings(
        title: AppStrings.kWindLabel,
        unitOptions: AppLists.kWindOptions,
        onSelected: (selected) {
          context.read<AppSettingsCubit>().setWindUnits(selected);
        },
        currentSelection: wind,
        unitsMap: AppMaps.kWindMappings,
      ),
    );
  }
}

class _PressureTile extends StatelessWidget {
  const _PressureTile();
  @override
  Widget build(BuildContext context) {
    final pressure = context.select(
      (AppSettingsCubit cubit) => switch (cubit.state) {
        SettingsLoaded settingsLoaded => settingsLoaded.pressure,
        _ => null,
      },
    );
    if (pressure == null) return const SizedBox.shrink();

    return SettingsMenuTile(
      unitSetting: UnitsSettings(
        title: AppStrings.kPressureLabel,
        unitOptions: AppLists.kPressureOptions,
        onSelected: (selected) {
          context.read<AppSettingsCubit>().setPressureUnits(selected);
        },
        currentSelection: pressure,
        unitsMap: AppMaps.kPressureMappings,
      ),
    );
  }
}

class _PrecipitationTile extends StatelessWidget {
  const _PrecipitationTile();

  @override
  Widget build(BuildContext context) {
    final precipitation = context.select(
      (AppSettingsCubit cubit) => switch (cubit.state) {
        SettingsLoaded settingsLoaded => settingsLoaded.precipitation,
        _ => null,
      },
    );
    if (precipitation == null) return const SizedBox.shrink();

    return SettingsMenuTile(
      unitSetting: UnitsSettings(
        title: AppStrings.kPrecipitationLabel,
        unitOptions: AppLists.kPrecipitationOptions,
        onSelected: (selected) {
          context.read<AppSettingsCubit>().setPrecipitationUnits(selected);
        },
        currentSelection: precipitation,
        unitsMap: AppMaps.kPrecipitationMappings,
      ),
    );
  }
}

class _VisibilityTile extends StatelessWidget {
  const _VisibilityTile();

  @override
  Widget build(BuildContext context) {
    final visibility = context.select(
      (AppSettingsCubit cubit) => switch (cubit.state) {
        SettingsLoaded settingsLoaded => settingsLoaded.visibility,
        _ => null,
      },
    );
    if (visibility == null) return const SizedBox.shrink();

    return SettingsMenuTile(
      unitSetting: UnitsSettings(
        title: AppStrings.kVisibilityLabel,
        unitOptions: AppLists.kVisibilityOptions,
        onSelected: (selected) {
          context.read<AppSettingsCubit>().setVisibilityUnits(selected);
        },
        currentSelection: visibility,
        unitsMap: AppMaps.kVisibilityMappings,
      ),
    );
  }
}
