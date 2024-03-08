import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/functions/elements/output_function_element.dart';
import 'package:flutter/material.dart';

class OutputFunctionCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorController controller;
  final String elementDataKey;
  const OutputFunctionCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<OutputFunctionCanvasElement> createState() =>
      _OutputFunctionCanvasElementState();
}

class _OutputFunctionCanvasElementState
    extends State<OutputFunctionCanvasElement> {
  @override
  void initState() {
    String? functionName = widget
        .controller
        .creatorData
        .currentCanvasElements[widget.elementDataKey]!
        .creatorAiData!
        .gptFunctionData!
        .name;
    String? functionCode = widget.controller.creatorData
        .customFunctionElementsWithCode[widget.elementDataKey];
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(loopRecieverCode: '''
  if(msg[0] =="${functionCode}"):
    ${functionName}()
    return
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasProgrammerSelector: true,
    );

    // widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
    //     .aiData = GptAiData()
    //   ..functionData = FunctionData(
    //     name: "scroll_the_response",
    //     description:
    //         '''This funciton is called to scroll the result in the display of bonic brain. The function must be called with the text as result parameter.
    //       The result should be without any special characters''',
    //     parameters: {
    //       "type": "object",
    //       "properties": {
    //         "result": {
    //           "type": "string",
    //           "minLength": 2,
    //           "maxLength": 9,
    //           "pattern": "^[a-zA-Z0-9_.-]*\$",
    //           "description":
    //               "The text data to be scrolled in the dispaly as an output. The parameter should be less than 9 characters without any special characters"
    //         }
    //       },
    //       "required": ["result"]
    //     },
    //   );

    if (widget
                .controller
                .creatorData
                .currentCanvasElements[widget.elementDataKey]!
                .creatorAiData!
                .bonicPythonCode ==
            null ||
        widget
            .controller
            .creatorData
            .currentCanvasElements[widget.elementDataKey]!
            .creatorAiData!
            .bonicPythonCode!
            .isEmpty) {
      widget
          .controller
          .creatorData
          .currentCanvasElements[widget.elementDataKey]!
          .creatorAiData!
          .bonicPythonCode = "display.scroll('function called')";
    }

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
        return OutputFunctionElement(
          data: data,
          controller: widget.controller,
        );
      },
    );
  }
}
