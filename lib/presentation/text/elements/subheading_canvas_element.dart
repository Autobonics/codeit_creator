import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/material.dart';

class SubheadingCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorController controller;
  const SubheadingCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<SubheadingCanvasElement> createState() =>
      _SubheadingCanvasElementState();
}

class _SubheadingCanvasElementState extends State<SubheadingCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      incrementValue: 3,
      hasTextInput: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      // data: widget.controller
      //     .currentCanvasElements[widget.elementDataKey],
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: 30,
      childBuilder: (data, isPressedDown) {
        return SubHeadingElement(
          data: data,
          isPressedDown: isPressedDown,
        );
      },
    );
  }
}
