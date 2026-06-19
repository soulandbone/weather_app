import 'package:flutter/material.dart';

class SwitchPeriod extends StatefulWidget {
  const SwitchPeriod({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;
  @override
  State<SwitchPeriod> createState() => _SwitchPeriodState();
}

class _SwitchPeriodState extends State<SwitchPeriod> {
  List<bool> selected = [true, false];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              widget.onChanged(true);
              setState(() {
                selected[0] = true;
                selected[1] = false;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:
                      selected[0]
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                'Today\'s Forecast',
                style: TextStyle(fontSize: selected[0] ? 18 : 12),
              ),
            ),
          ),

          InkWell(
            onTap: () {
              widget.onChanged(false);
              setState(() {
                selected[0] = false;
                selected[1] = true;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:
                      selected[1]
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                '3-day Forecast',
                style: TextStyle(fontSize: selected[1] ? 18 : 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
