import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final HugeIcon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(subtitle, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}
