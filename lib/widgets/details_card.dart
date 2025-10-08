import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle),
      ],
    );
  }
}
