import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/Display/elements/setPixel_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class SetPixelCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorControllerBase controller;
  final String elementDataKey;
  const SetPixelCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<SetPixelCanvasElement> createState() => _SetPixelCanvasElementState();
}

class _SetPixelCanvasElementState extends State<SetPixelCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(interruptRecieverCode: '''
  if(msg[0] =="\$"):
    display.set_pixel_index(int(msg[1:3]),msg[3:10])
    return
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      // data: widget.element,
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.2,
      childBuilder: (data, isPressedDown) {
        return SetPixelElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
