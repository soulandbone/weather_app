import 'package:flutter/material.dart';

class SwitchPeriod extends StatelessWidget {
  const SwitchPeriod({
    super.key,
    required this.isOneDay,
    required this.onChanged,
  });

  final ValueChanged<bool> onChanged;
  final bool isOneDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onChanged(true);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:
                      isOneDay
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Today\'s Forecast',
                style: TextStyle(fontSize: isOneDay ? 18 : 12),
              ),
            ),
          ),

          InkWell(
            onTap: () {
              onChanged(false);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color:
                      !isOneDay
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.surface,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                '3-day Forecast',
                style: TextStyle(fontSize: !isOneDay ? 18 : 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
