import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_settings_state.dart';
import 'package:weather_app/enums/wind_units.dart';
import 'package:weather_app/presentation/widgets/details_card.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({
    required this.windSpeedKm,
    required this.humidity,
    required this.rainChance,
    required this.windSpeedMiles,
    super.key,
  });
  final String windSpeedKm;
  final String windSpeedMiles;
  final String humidity;
  final String rainChance;

  @override
  Widget build(BuildContext context) {
    final windUnits = context.select<AppSettingsCubit, WindUnits>((cubit) {
      final currentState = cubit.state;

      if (currentState is SettingsLoaded) {
        return currentState.wind;
      } else {
        return WindUnits.kilometersPerHour;
      }
    });

    String windText = switch (windUnits) {
      WindUnits.kilometersPerHour => "km/h",
      WindUnits.metersPerSecond => "m/s",
      WindUnits.feetPerSecond => "ft/s",
      WindUnits.milesPerHour => "mi/h",
      WindUnits.nauticalMilesPerHour => "kts",
    };

    String windValue = switch (windUnits) {
      WindUnits.kilometersPerHour => windSpeedKm,
      WindUnits.metersPerSecond => (double.parse(windSpeedKm) / 3.6)
          .toStringAsFixed(2),
      WindUnits.feetPerSecond => (double.parse(windSpeedMiles) * 1.467)
          .toStringAsFixed(2),
      WindUnits.milesPerHour => windSpeedMiles,
      WindUnits.nauticalMilesPerHour => (double.parse(windSpeedMiles) / 1.151)
          .toStringAsFixed(2),
    };

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailsCard(
            icon: HugeIcon(
              color: Colors.white,
              icon: HugeIcons.strokeRoundedFastWind,
              strokeWidth: 2.5,
            ),
            title: "$windValue $windText",
            subtitle: AppStrings.kWindLabel,
          ),
          Gap(5),
          DetailsCard(
            icon: HugeIcon(
              color: Colors.white,
              icon: HugeIcons.strokeRoundedDroplet,
              strokeWidth: 2.5,
            ),
            title: '$humidity%',
            subtitle: AppStrings.kHumidityLabel,
          ),
          Gap(5),
          DetailsCard(
            icon: HugeIcon(
              color: Colors.white,
              icon: HugeIcons.strokeRoundedCloudLittleRain,
              strokeWidth: 2.5,
            ),
            title: rainChance,
            subtitle: AppStrings.kRainPercentageLabel,
          ),
        ],
      ),
    );
  }
}
