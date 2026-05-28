import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:weather_app/helpers/date_formatter.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/presentation/widgets/details_info.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    required this.mainWeatherInfo,
    required this.isCelsius,
    super.key,
  });

  final MainWeatherInfo mainWeatherInfo;
  final bool isCelsius;

  @override
  Widget build(BuildContext context) {
    var dateFormatter = DateFormatter();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),

      child: Column(
        children: [
          Gap(20),
          Center(
            child: Text(
              mainWeatherInfo.locationCity,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          Gap(20),
          Image.network(mainWeatherInfo.imageUrl, scale: 0.4),

          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCelsius
                    ? mainWeatherInfo.temperatureCelsius
                    : mainWeatherInfo.temperatureFahrenheit,
                style: GoogleFonts.orbitron(
                  textStyle: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                isCelsius ? '°C' : '°F',
                style: GoogleFonts.orbitron(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          Text(mainWeatherInfo.condition, style: TextStyle(fontSize: 24)),
          Text((dateFormatter.formatDate(DateTime.now()))),
          Gap(40),
          Divider(color: Colors.white54, thickness: 1),
          Center(
            child: DetailsInfo(
              humidity: mainWeatherInfo.humidity,
              windSpeedKm: mainWeatherInfo.windSpeedKm,
              windSpeedMiles: mainWeatherInfo.windSpeedMi,
              rainChance: mainWeatherInfo.rainChance,
            ),
          ),
          Gap(40),
        ],
      ),
    );
  }
}
