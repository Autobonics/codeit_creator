import 'package:codeit_creator/presentation/Display/elements/led.dart';
import 'package:codeit_creator/utilities/converters.dart';
import 'package:codeit_creator/utilities/creator_color_picker.dart';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/utilities/wrappers.dart';
import 'package:flutter/material.dart';

class SetPixelElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorController? controller;

  const SetPixelElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<SetPixelElement> createState() => _SetPixelElementState();
}

class _SetPixelElementState extends State<SetPixelElement> {
  late Color currentSelectedColor;

  _listner() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    widget.data?.addListener(_listner);
    currentSelectedColor = Converters.colorFromString(
            widget.data?.widgetData['currentSelectedColor']) ??
        Color(0xff0088CC);
    super.initState();
  }

  @override
  void dispose() {
    widget.data?.removeListener(_listner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;
    _getMatrix() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: size * 0.03,
          mainAxisSpacing: size * 0.03,
        ),
        physics: ClampingScrollPhysics(),
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return Led(
            index: index,
            initColor: Converters.colorFromString(
                widget.data?.widgetData[index.toString()]),
            margin: EdgeInsets.all(3),
            onPressed: widget.controller?.isEditMode.value == false
                ? (int index, ColorWrapper color) {
                    color.value = currentSelectedColor;
                    String indexString = index.toString().padLeft(2, '0');
                    String colorHex =
                        '#${color.value.value.toRadixString(16).substring(2, 8)}';
                    widget.controller?.viewModel
                        .sendMessage('\$$indexString$colorHex');
                    widget.data?.widgetData[index.toString()] =
                        Converters.colorToString(color.value);
                  }
                : null,
          );
        },
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: widget.data?.color ?? CreatorConsts.creatorDisplayColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 20)],
        ),
        width: size,
        height: size + size / 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              value: currentSelectedColor,
              onColorPicked: widget.controller?.isEditMode.value == false
                  ? (color) {
                      currentSelectedColor = color;
                      widget.data?.widgetData['currentSelectedColor'] =
                          Converters.colorToString(color);
                    }
                  : null,
              maxWidth: size,
              colorOptions: [
                Color(0xffFF00FF),
                Color(0xff7B9A00),
                Color(0xff0088CC),
                Color(0xffDE324F),
                Color(0xff000000),
              ],
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getMatrix(),
            )),
          ],
        ),
      ),
    );
  }
}
