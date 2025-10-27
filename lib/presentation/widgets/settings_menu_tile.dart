import 'package:flutter/material.dart';
import 'package:weather_app/models/units_settings.dart';
import 'package:weather_app/presentation/screens/modals/custom_modal.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    required this.unitSetting,
    // required this.getString,
    // required this.getEnum,
    super.key,
  });

  final UnitsSettings unitSetting;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(unitSetting.title),
        subtitle: Text(unitSetting.unitsMap[unitSetting.currentSelection]!),
        onTap:
            () => showModalBottomSheet(
              context: context,
              builder: (context) => CustomModal(unitsSettings: unitSetting),
            ),
      ),
    );
  }
}
