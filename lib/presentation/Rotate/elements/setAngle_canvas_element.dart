import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/presentation/Rotate/elements/setAngle_element.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class SetAngleCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorControllerBase controller;
  const SetAngleCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<SetAngleCanvasElement> createState() => _SetAngleCanvasElementState();
}

class _SetAngleCanvasElementState extends State<SetAngleCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(interruptRecieverCode: '''
  port = ports[int(msg[1])-1]
  if(msg[0] =="&"):
    rotate.set_angle(port,int(msg[2:]))
    return
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasPortPicker: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      // data: widget.controller
      //     .currentCanvasElements[widget.elementDataKey],
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.2,
      childBuilder: (data, isPressedDown) {
        return SetAngleElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
