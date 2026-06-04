import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/hourly_container.dart';

class ScrollableRow<T> extends StatefulWidget {
  const ScrollableRow({
    required this.height,
    required this.details,
    required this.isCelsius, // this has to be a list

    super.key,
  });

  final double height;
  final bool isCelsius;
  final List<T> details;

  @override
  State<ScrollableRow> createState() => _ScrollableRowState();
}

class _ScrollableRowState extends State<ScrollableRow> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.filled(widget.details.length, false);
  }

  void setSelected(int index) {
    setState(() {
      for (var i = 0; i < selected.length; i++) {
        selected[i] = index == i;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(selected.length);
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selected.length,
        itemBuilder:
            (context, index) => HourlyContainer(
              isCelsius: widget.isCelsius,
              onSelection: () {
                setSelected(index);
              },
              isSelected: selected[index],
              hourlyWeatherDetails: widget.details[index],
            ),
      ),
    );
  }
}
