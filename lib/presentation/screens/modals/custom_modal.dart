import 'package:flutter/material.dart';

class CustomModal<T> extends StatelessWidget {
  const CustomModal({
    required this.title,
    required this.optionsTexts,
    required this.onSelected,
    required this.currentSelection,
    required this.getString,

    super.key,
  });

  final String title; //Title of the Modal
  final List<String> optionsTexts; //Options displayed in the modal
  final Function(String selection)
  onSelected; //the function that actually takes care of updating the state with the new selection
  final T
  currentSelection; //watches the currentActiveState, needed to then use it as comparison to what was selected on the List and display the checkMark
  final String Function(T)
  getString; //Util function to getString from the state (which is an enum)

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: Column(
        children: [
          Center(child: Text(title)),
          Expanded(
            child: ListView.builder(
              itemCount: optionsTexts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onSelected(optionsTexts[index]);
                  },
                  child: ListTile(
                    title: Text(optionsTexts[index]),
                    trailing: Visibility(
                      visible:
                          getString(currentSelection) == optionsTexts[index],

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
