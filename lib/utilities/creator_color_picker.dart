import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final void Function(Color color)? onColorPicked;
  final Color? value;
  final double maxWidth;
  final List<Color> colorOptions;
  const ColorPicker({
    Key? key,
    required this.onColorPicked,
    this.value,
    required this.maxWidth,
    required this.colorOptions,
    // required this.data,
  }) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? currentColor;

  @override
  void initState() {
    currentColor = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double containerSize = widget.maxWidth / 5;
    _getColorContainer(Color color) {
      double padding =
          currentColor == color ? containerSize * 0.2 : containerSize * 0.25;
      return InkWell(
        onTap: widget.onColorPicked == null
            ? null
            : () {
                currentColor = color;
                setState(() {});
                widget.onColorPicked!(color);
              },
        child: Container(
          width: containerSize,
          height: containerSize,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      child: Row(
        children:
            widget.colorOptions.map((e) => _getColorContainer(e)).toList(),
      ),
    );
  }
}
