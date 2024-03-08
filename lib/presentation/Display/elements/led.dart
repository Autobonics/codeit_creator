import 'package:codeit_creator/utilities/wrappers.dart';
import 'package:flutter/material.dart';

class Led extends StatefulWidget {
  final void Function(int index, ColorWrapper color)? onPressed;
  final int index;
  final EdgeInsets margin;
  final Color? initColor;

  const Led({
    Key? key,
    required this.onPressed,
    required this.index,
    required this.margin,
    this.initColor,
  }) : super(key: key);

  @override
  State<Led> createState() => _LedState();
}

class _LedState extends State<Led> {
  late ColorWrapper color;

  @override
  void initState() {
    color = ColorWrapper(widget.initColor ?? Colors.black);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed != null
          ? () {
              widget.onPressed!(widget.index, color);
              setState(() {});
            }
          : null,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: widget.margin,
          child: Container(
            decoration: BoxDecoration(
              color: color.value,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
