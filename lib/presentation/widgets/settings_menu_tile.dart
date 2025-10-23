import 'package:flutter/material.dart';
import 'package:weather_app/presentation/screens/modals/custom_modal.dart';

class SettingsMenuTile<T> extends StatelessWidget {
  const SettingsMenuTile({
    required this.title,
    required this.subtitle,
    required this.optionsText,
    required this.onSelected,
    required this.currentSelection,
    required this.getString,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<String> optionsText;
  final Function(String selectedOption)
  onSelected; //function to detect the option selected and set the globalState for the given unit
  final T
  currentSelection; //gets the currentState from the global State. Is of type Enum, hence the T
  final String Function(T)
  getString; //comes from the current state and is an enum

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap:
            () => showModalBottomSheet(
              context: context,
              builder:
                  (context) => CustomModal(
                    title: title,
                    optionsTexts: optionsText,
                    onSelected: onSelected,
                    currentSelection: currentSelection,
                    getString: getString,
                  ),
            ),
      ),
    );
  }
}
