import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/move/elements/move_element.dart';
import 'package:flutter/material.dart';

enum MoveDirection { Clockwise, AntiClockwise }

class MoveCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;
  final CreatorControllerBase controller;
  const MoveCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<MoveCanvasElement> createState() => _MoveCanvasElementState();
}

class _MoveCanvasElementState extends State<MoveCanvasElement> {
  late CreatorElementData data;

  @override
  void initState() {
    data = widget
        .controller.creatorData.currentCanvasElements[widget.elementDataKey]!;
    data.setCode(interruptRecieverCode: '''
  if(msg[0] =="!"):
    port = ports[int(msg[1])-1]
    move.forward(port,500)
    return
  if(msg[0] =='"'):
    port = ports[int(msg[1])-1]
    move.reverse(port,500)
    return
  if(msg[0] =="#"):
    port = ports[int(msg[1])-1]
    move.stop(port)
    return
''');
    data.optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasDirectionPicker: true,
      hasPortPicker: true,
    );

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .creatorAiData = CreatorAiData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreatorCanvasElement(
      // data: data,
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      defaultSize: MediaQuery.of(context).size.width * 0.15,

      onTapDown: () {
        if (widget.controller.isEditMode.value) return;
        int port = data.port!;
        String dir = data.moveDirection! == MoveDirection.Clockwise ? '!' : '"';
        widget.controller.viewModel.sendMessage('${dir}${port}');
      },
      onTapUp: () {
        if (widget.controller.isEditMode.value) return;
        int port = data.port!;
        widget.controller.viewModel.sendMessage('#${port}');
      },
      childBuilder: (data, isPressedDown) {
        return MoveElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
