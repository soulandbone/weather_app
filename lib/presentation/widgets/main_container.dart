import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/presentation/widgets/details_info.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    required this.mainWeatherInfo,
    required this.onPressed,
    super.key,
  });

  final MainWeatherInfo mainWeatherInfo;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
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
          Image.asset('assets/sun.png'),
          TextButton.icon(
            icon: Icon(Icons.abc),
            onPressed: onPressed,
            label: Text('Get Location', style: TextStyle(color: Colors.white)),
          ),

          Gap(20),
          Text(
            '${mainWeatherInfo.temperatureCelsius}°',
            style: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(mainWeatherInfo.condition, style: TextStyle(fontSize: 24)),
          Text('Monday, 17 May'),
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
