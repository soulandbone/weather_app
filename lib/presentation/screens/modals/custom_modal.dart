import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/app_settings_cubit.dart';
import 'package:weather_app/utils/utils.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({
    required this.title,
    required this.optionsTexts,
    required this.onSelected,
    super.key,
  });

  final String title;
  final List<String> optionsTexts;
  final Function(String selection) onSelected;

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  @override
  Widget build(BuildContext context) {
    var currentSelection = context.watch<AppSettingsCubit>().state.temperature;
    String temperature = Utils.getTemperatureString(currentSelection);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: Column(
        children: [
          Center(child: Text(widget.title)),
          Expanded(
            child: ListView.builder(
              itemCount: widget.optionsTexts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<AppSettingsCubit>().setTempUnits(
                      Utils.getTemperatureEnum(widget.optionsTexts[index]),
                    );
                  },
                  child: ListTile(
                    title: Text(widget.optionsTexts[index]),
                    trailing: Visibility(
                      visible: temperature == widget.optionsTexts[index],

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
