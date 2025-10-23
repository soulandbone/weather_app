import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/app_strings.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/settings_state.dart';
import 'package:weather_app/presentation/screens/modals/custom_modal.dart';
import 'package:weather_app/presentation/widgets/settings_menu_tile.dart';
import 'package:weather_app/utils/utils.dart';

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
                title: AppStrings.kTemperatureLabel,
                subtitle: Utils.getTemperatureString(state.temperature),
                optionsText: AppLists.temperatureOptions,
                onSelected: (selectedTemperature) {
                  context.read<AppSettingsCubit>().setTempUnits(
                    Utils.getTemperatureEnum(selectedTemperature),
                  );
                },
                currentSelection:
                    context.watch<AppSettingsCubit>().state.temperature,
                getString: Utils.getTemperatureString,
              ),

              ListTile(
                title: Text('Wind'),
                subtitle: Text('Kilometers per hour -km/h'),
              ),
              ListTile(
                title: Text('Precipitation'),
                subtitle: Text('Milimeters -mm'),
              ),
              ListTile(
                title: Text('Visibility'),
                subtitle: Text('Kilometers -km'),
              ),
              ListTile(
                title: Text('Pressure'),
                subtitle: Text('Hectopascals - hPa'),
              ),
            ],
          );
        },
      ),
    );
  }
}
