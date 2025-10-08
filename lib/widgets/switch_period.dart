import 'package:flutter/material.dart';

class SwitchPeriod extends StatefulWidget {
  const SwitchPeriod({super.key});

  @override
  State<SwitchPeriod> createState() => _SwitchPeriodState();
}

class _SwitchPeriodState extends State<SwitchPeriod> {
  List<bool> selected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selected[0] = true;
              selected[1] = false;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              'Left',
              style: TextStyle(fontSize: selected[0] ? 18 : 12),
            ),
          ),
        ),

        InkWell(
          onTap: () {
            setState(() {
              selected[0] = false;
              selected[1] = true;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              'Right',
              style: TextStyle(fontSize: selected[1] ? 18 : 12),
            ),
          ),
        ),
      ],
    );
  }
}
