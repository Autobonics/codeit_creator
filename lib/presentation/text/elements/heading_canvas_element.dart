import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/material.dart';

class HeadingCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorController controller;
  const HeadingCanvasElement({
    super.key,
    required this.controller,
    required this.elementDataKey,
  });

  @override
  State<HeadingCanvasElement> createState() => _HeadingCanvasElementState();
}

class _HeadingCanvasElementState extends State<HeadingCanvasElement> {
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
      defaultSize: 50,
      childBuilder: (data, isPressedDown) {
        return HeadingTextElement(
          data: data,
          isPressedDown: isPressedDown,
        );
      },
    );
  }
}
