import 'package:flutter/material.dart';
import 'package:weather_app/models/units_settings.dart';

class CustomModal<T> extends StatefulWidget {
  const CustomModal({required this.unitsSettings, super.key});

  final UnitsSettings unitsSettings;

  @override
  State<CustomModal<T>> createState() => _CustomModalState<T>();
}

class _CustomModalState<T> extends State<CustomModal<T>> {
  late T selected;

  @override
  void initState() {
    super.initState();
    selected = widget.unitsSettings.currentSelection;
  }

  @override
  void didUpdateWidget(covariant CustomModal<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.unitsSettings.currentSelection != selected) {
      setState(() {
        selected = widget.unitsSettings.currentSelection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var unitsSettings = widget.unitsSettings;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: Column(
        children: [
          Center(child: Text(unitsSettings.title)),
          Expanded(
            child: ListView.builder(
              itemCount: unitsSettings.unitOptions.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    unitsSettings.onSelected(unitsSettings.unitOptions[index]);
                    setState(() {
                      selected = unitsSettings.unitOptions[index];
                    });
                  },

                  child: ListTile(
                    title: Text(
                      unitsSettings.unitsMap[unitsSettings.unitOptions[index]]!,
                    ),
                    trailing: Visibility(
                      visible:
                          selected ==
                          unitsSettings
                              .unitOptions[index], //unitsSettings.unitOptions[index]

                      child: Icon(Icons.check),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
