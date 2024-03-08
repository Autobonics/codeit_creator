import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/Music/elements/piano_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class PianoCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorController controller;
  final String elementDataKey;

  const PianoCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<PianoCanvasElement> createState() => _PianoCanvasElementState();
}

class _PianoCanvasElementState extends State<PianoCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(loopRecieverCode: '''
  if(msg[0] =="'"):
    music.play([msg[1:]],300)
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
      // data: widget.controller
      //     .currentCanvasElements[widget.elementDataKey],
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.2,
      childBuilder: (data, isPressedDown) {
        // return Container();
        return PianoElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
