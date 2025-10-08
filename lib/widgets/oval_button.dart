import 'package:flutter/material.dart';

class OvalButton extends StatelessWidget {
  const OvalButton({
    required this.temperature,
    required this.icon,
    required this.time,
    super.key,
  });
  final String temperature;
  final IconData icon;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            temperature,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(icon),
          Text(time, style: TextStyle(fontSize: 10, color: Colors.white)),
        ],
      ),
    );
  }
}
