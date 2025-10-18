import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({
    required this.title,
    required this.optionsTexts,
    super.key,
  });

  final String title;
  final List<String> optionsTexts;

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.optionsTexts.length, (n) {
      if (n == 0) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                return ListTile(
                  title: Text(widget.optionsTexts[index]),
                  trailing: Visibility(
                    visible: isSelected[index],
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(child: Text('Close')),
        ],
      ),
    );
  }
}
