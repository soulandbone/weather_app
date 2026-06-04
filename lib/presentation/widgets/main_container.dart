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
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),

      child: Column(
        children: [
          const Gap(20),
          Center(
            child: Text(
              "${mainWeatherInfo.locationCity},${mainWeatherInfo.locationCountry}  ",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(20),
          Image.network(mainWeatherInfo.imageUrl, scale: 0.4),

          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCelsius
                    ? mainWeatherInfo.temperatureCelsius.toString()
                    : mainWeatherInfo.temperatureFahrenheit.toString(),
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                isCelsius ? '°C' : '°F',
                style: GoogleFonts.orbitron(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          Text(mainWeatherInfo.condition, style: const TextStyle(fontSize: 24)),
          Text((dateFormatter.formatDate(DateTime.now()))),
          const Gap(40),
          const Divider(color: Colors.white54, thickness: 1),
          Center(
            child: DetailsInfo(
              humidity: mainWeatherInfo.humidity.toString(),
              windSpeedKm: mainWeatherInfo.windSpeedKm.toString(),
              windSpeedMiles: mainWeatherInfo.windSpeedMi.toString(),
              rainChance: mainWeatherInfo.rainChance.toString(),
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}
