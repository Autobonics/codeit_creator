import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/button/elements/is_pressed_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class IsPressedCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorControllerBase controller;
  final String elementDataKey;
  const IsPressedCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<IsPressedCanvasElement> createState() => _IsPressedCanvasElementState();
}

class _IsPressedCanvasElementState extends State<IsPressedCanvasElement> {
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
    // return Positioned(
    //     child: IsPressedElement(
    //   data: null,
    //   isPressedDown: false,
    //   controller: widget.controller,
    // ));

    return CreatorCanvasElement(
      elementDataKey: widget.elementDataKey,
      // data: widget.element,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.125,
      childBuilder: (data, isPressedDown) {
        return IsPressedElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
