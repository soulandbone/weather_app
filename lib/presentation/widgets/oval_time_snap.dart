import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';

class OvalTimeSnap extends StatelessWidget {
  const OvalTimeSnap({
    required this.hourlyWeatherDetails,
    required this.isSelected,
    required this.onSelection,
    super.key,
  });
  final HourlyWeatherDetails hourlyWeatherDetails;
  final bool isSelected;
  final VoidCallback onSelection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelection,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              hourlyWeatherDetails.temperature,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
            ),
            Image.network(hourlyWeatherDetails.stringUrl),
            Text(
              hourlyWeatherDetails.time,
              style: TextStyle(fontSize: 8, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
