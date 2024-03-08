import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/src/widgets/framework.dart';

class BonicCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final String elementDataKey;

  final CreatorController controller;
  const BonicCanvasElement({
    Key? key,
    required this.controller,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<BonicCanvasElement> createState() => _BonicCanvasElementState();
}

class _BonicCanvasElementState extends State<BonicCanvasElement> {
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
      elementDataKey: widget.elementDataKey,
      // data: widget.controller
      //     .currentCanvasElements[widget.elementDataKey],
      controller: widget.controller,
      defaultSize: 60,
      childBuilder: (data, isPressedDown) {
        return BonicTextElement(
          data: data,
          isPressedDown: isPressedDown,
        );
      },
    );
  }
}
