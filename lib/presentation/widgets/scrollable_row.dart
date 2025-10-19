import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_models.dart';
import 'package:weather_app/presentation/widgets/oval_time_snap.dart';

class ScrollableRow extends StatefulWidget {
  const ScrollableRow({
    required this.height,
    required this.hourbyHourDetails, // this has to be a list

    super.key,
  });

  final double height;
  final HourbyHourDetails hourbyHourDetails;

  @override
  State<ScrollableRow> createState() => _ScrollableRowState();
}

class _ScrollableRowState extends State<ScrollableRow> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.filled(widget.hourbyHourDetails.hourlyData.length, false);
    print(widget.hourbyHourDetails.hourlyData.length);
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
            (context, index) => OvalTimeSnap(
              onSelection: () {
                setSelected(index);
              },
              isSelected: selected[index],
              hourlyWeatherDetails: widget.hourbyHourDetails.hourlyData[index],
            ),
      ),
    );
  }
}
