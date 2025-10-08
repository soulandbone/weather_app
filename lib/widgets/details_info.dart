import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/widgets/details_card.dart';

class DetailsInfo extends StatelessWidget {
  const DetailsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailsCard(
            icon: FontAwesomeIcons.wind,
            title: '13km/h',
            subtitle: 'Wind',
          ),
          DetailsCard(icon: Icons.water, title: '24%', subtitle: 'Humidity'),
          DetailsCard(icon: Icons.abc, title: '84%', subtitle: 'Rain %'),
        ],
      ),
    );
  }
}
