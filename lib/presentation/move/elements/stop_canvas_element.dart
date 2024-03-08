import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/move/elements/stop_element.dart';
import 'package:flutter/material.dart';

class StopCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorController controller;
  const StopCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<StopCanvasElement> createState() => _StopCanvasElementState();
}

class _StopCanvasElementState extends State<StopCanvasElement> {
  @override
  void initState() {
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
      defaultSize: MediaQuery.of(context).size.width * 0.15,
      elementDataKey: widget.elementDataKey,
      controller: widget.controller,
      onTapUp: () {},
      onTapDown: () {
        if (widget.controller.isEditMode.value) return;
        int port = widget.controller.creatorData
            .currentCanvasElements[widget.elementDataKey]!.port!;
        widget.controller.viewModel.sendMessage('#${port}');
      },
      childBuilder: (data, isPressedDown) {
        return StopElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
