import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:weather_app/models/weather_models.dart';

class DailyContainer extends StatelessWidget {
  const DailyContainer({
    required this.forecast,
    required this.isSelected,
    required this.onSelection,
    required this.isCelsius,
    required this.width,
    super.key,
  });
  final DailyForecast forecast;
  final bool isSelected;
  final bool isCelsius;
  final VoidCallback onSelection;
  final double width;

  final iconSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelection,
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.network(forecast.stringUrl, scale: 1.4),
            Text(
              isCelsius ? "${forecast.avgTempC} °C" : "${forecast.avgTempF} °F",
              style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowDown02,
                  size: iconSize,
                  color: Colors.white,
                ),
                Text(
                  isCelsius
                      ? "${forecast.minTempC} °C"
                      : "${forecast.minTempF} °F",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                Gap(10),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowUp02,
                  size: iconSize,
                  color: Colors.white,
                ),
                Text(
                  isCelsius
                      ? "${forecast.maxTempC} °C"
                      : "${forecast.maxTempF} °F",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
