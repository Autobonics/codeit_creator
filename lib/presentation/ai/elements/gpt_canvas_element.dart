import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/ai/elements/gpt_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class GptCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorControllerBase controller;
  final String elementDataKey;
  const GptCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<GptCanvasElement> createState() => _GptCanvasElementState();
}

class _GptCanvasElementState extends State<GptCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(mainFunctionCode: '''
      messaging.send('bA'+str(button_A.is_pressed()))
      messaging.send('bB'+str(button_B.is_pressed()))
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasTextInput: true,
      hasButtonPicker: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.15,
      childBuilder: (data, isPressedDown) {
        return GptElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
