import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/input/elements/distance_element.dart';
import 'package:flutter/material.dart';

class DistanceCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;
  final CreatorControllerBase controller;
  const DistanceCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<DistanceCanvasElement> createState() => _DistanceCanvasElementState();
}

class _DistanceCanvasElementState extends State<DistanceCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(mainFunctionCode: '''
      messaging.send('d'+str(distance.get_value()))
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData()
      ..gptFunctionData = GptFunctionData(
        name: "get_current_distance",
        description:
            "Get the current distance from the proximity sensor on bonic brain to the obstacle infront in milli meters.",
        parameters: {
          "type": "object",
          "properties": {
            "dummy_property": {
              "type": "null",
            }
          },
        },
        hasParameter: false,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      // data: widget.element,
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.125,
      childBuilder: (data, isPressedDown) {
        return DistanceElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
