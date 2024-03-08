import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/input/elements/temperature_element.dart';
import 'package:flutter/material.dart';

class TemperatureCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;
  final CreatorControllerBase controller;
  const TemperatureCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<TemperatureCanvasElement> createState() =>
      _TemperatureCanvasElementState();
}

class _TemperatureCanvasElementState extends State<TemperatureCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(mainFunctionCode: '''
      messaging.send('t'+str(int(temperature())))
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData()
      ..gptFunctionData = GptFunctionData(
        hasParameter: false,
        name: "get_current_room_temperature",
        description:
            "Get the current room temperature from the temperature sensor on bonic brain.",
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
      // data: widget.element,
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.125,
      childBuilder: (data, isPressedDown) {
        return TemperatureElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
