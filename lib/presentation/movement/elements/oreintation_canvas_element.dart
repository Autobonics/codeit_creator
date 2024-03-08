import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/movement/elements/orientation_element.dart';
import 'package:flutter/material.dart';

class OrientationCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorControllerBase controller;
  final String elementDataKey;

  const OrientationCanvasElement({
    super.key,
    required this.controller,
    required this.elementDataKey,
  });

  @override
  State<OrientationCanvasElement> createState() =>
      _OrientationCanvasElementState();
}

class _OrientationCanvasElementState extends State<OrientationCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(mainFunctionCode: '''
      messaging.send('o'+str(int(movement.angle_x()))+','+str(int(movement.angle_y())))
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData()
      ..gptFunctionData = GptFunctionData(
        hasParameter: false,
        name: "get_current_gyroscope_angle",
        description:
            "Get the current orientation angles of the bonic brain  in x and y axis from the gyroscope sensor on bonic brain.",
        parameters: {
          "type": "object",
          "properties": {
            "dummy_property": {
              "type": "null",
            }
          },
        },
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
      defaultSize: MediaQuery.of(context).size.width * 0.1,
      childBuilder: (data, isPressedDown) {
        return OrientationElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
