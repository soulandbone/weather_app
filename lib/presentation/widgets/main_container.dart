import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/cubits/app_settings_state.dart';
import 'package:weather_app/enums/temperature_units.dart';
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
          Center(
            child: Text(
              mainWeatherInfo.locationCity,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Gap(20),
          Image.network(mainWeatherInfo.imageUrl, scale: 0.5),

          Gap(20),
          Text(
            isCelsius
                ? '${mainWeatherInfo.temperatureCelsius} °C'
                : '${mainWeatherInfo.temperatureFahrenheit} °F',
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(mainWeatherInfo.condition, style: TextStyle(fontSize: 24)),
          Text((dateFormatter.formatDate(DateTime.now()))),
          Gap(40),
          Divider(color: Colors.white54, thickness: 1),
          Center(
            child: DetailsInfo(
              humidity: mainWeatherInfo.humidity,
              windSpeed: mainWeatherInfo.windSpeedKm,
              rainChance: mainWeatherInfo.rainChance,
            ),
          ),
          Gap(40),
        ],
      ),
    );
  }
}
