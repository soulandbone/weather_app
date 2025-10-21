import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({
    required this.title,
    required this.optionsTexts,
    required this.onSelected,
    super.key,
  });

  final String title;
  final List<String> optionsTexts;
  final Function onSelected;

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
                return InkWell(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < isSelected.length; i++) {
                        isSelected[i] = index == i;
                      }
                    });
                  },
                  child: ListTile(
                    title: Text(widget.optionsTexts[index]),
                    trailing: Visibility(
                      visible: isSelected[index],
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
