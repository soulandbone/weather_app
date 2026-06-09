import 'package:flutter/material.dart';

class ScrollableRow<T> extends StatefulWidget {
  const ScrollableRow({
    required this.height,
    required this.details,

    required this.itemBuilder,
    super.key,
  });

  final double height;

  final List<T> details;
  final Widget Function(
    BuildContext context,
    int index,
    bool isSelected,
    VoidCallback onSelection,
  )
  itemBuilder;

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
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selected.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(
            context,
            index,
            selected[index],
            () => setSelected(index),
          );
        },
      ),
    );
  }
}
