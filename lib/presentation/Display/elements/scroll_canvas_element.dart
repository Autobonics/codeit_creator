import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/Display/elements/scroll_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class ScrollCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorControllerBase controller;
  final String elementDataKey;
  const ScrollCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<ScrollCanvasElement> createState() => _ScrollCanvasElementState();
}

class _ScrollCanvasElementState extends State<ScrollCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(loopRecieverCode: '''
  if(msg[0] =="%"):
    display.scroll(msg[1:])
    return
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasTextInput: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData()
      ..gptFunctionData = GptFunctionData(
        name: "scroll_the_response",
        description:
            '''This funciton is called to scroll the result in the display of bonic brain. The function must be called with the text as result parameter. 
          The result should be without any special characters''',
        parameters: {
          "type": "object",
          "properties": {
            "result": {
              "type": "string",
              "minLength": 2,
              "maxLength": 9,
              "pattern": "^[a-zA-Z0-9_.-]*\$",
              "description":
                  "The text data to be scrolled in the dispaly as an output. The parameter should be less than 9 characters without any special characters"
            }
          },
          "required": ["result"]
        },
        hasParameter: true,
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
        return ScrollElement(
          data: data,
          controller: widget.controller,
        );
      },
    );
  }
}
