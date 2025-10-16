import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/widgets/details_card.dart';

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({
    required this.windSpeed,
    required this.humidity,
    required this.rainChance,
    super.key,
  });
  final String windSpeed;
  final String humidity;
  final String rainChance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailsCard(
            icon: FontAwesomeIcons.wind,
            title: '${windSpeed}km/h',
            subtitle: 'Wind',
          ),
          Gap(5),
          DetailsCard(
            icon: Icons.water,
            title: '$humidity%',
            subtitle: 'Humidity',
          ),
          Gap(5),
          DetailsCard(icon: Icons.abc, title: rainChance, subtitle: 'Rain %'),
        ],
      ),
    );
  }
}
