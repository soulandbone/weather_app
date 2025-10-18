import 'package:flutter/material.dart';
import 'package:weather_app/screens/modals/custom_modal.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
            child: ListTile(
              title: Text('Temperature'),
              subtitle: Text('Celsius C'),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => CustomModal(
                        title: 'Temperature',
                        optionsTexts: ['Celsius - C', 'Fahrenheit - F'],
                      ),
                );
              },
            ),
          ),
          ListTile(
            title: Text('Wind'),
            subtitle: Text('Kilometers per hour -km/h'),
          ),
          ListTile(
            title: Text('Precipitation'),
            subtitle: Text('Milimeters -mm'),
          ),
          ListTile(title: Text('Visibility'), subtitle: Text('Kilometers -km')),
          ListTile(
            title: Text('Pressure'),
            subtitle: Text('Hectopascals - hPa'),
          ),
        ],
      ),
    );
  }
}
