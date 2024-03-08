import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/src/widgets/framework.dart';

class BodyCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorControllerBase controller;
  const BodyCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<BodyCanvasElement> createState() => _BodyCanvasElementState();
}

class _BodyCanvasElementState extends State<BodyCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      incrementValue: 3,
      hasTextInput: true,
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
      defaultSize: 27,
      childBuilder: (data, isPressedDown) {
        return BodyTextElement(
          data: data,
          isPressedDown: isPressedDown,
        );
      },
    );
  }
}
