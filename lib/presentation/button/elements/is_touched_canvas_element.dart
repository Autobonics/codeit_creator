import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/button/elements/is_touched_element.dart';
import 'package:codeit_creator/presentation/creator_canvas_element.dart';
import 'package:codeit_creator/data/creator_element_data.dart';

import 'package:flutter/material.dart';

class IsTouchedCanvasElement extends StatefulWidget {
  // final CreatorElementData element;
  final CreatorController controller;
  final String elementDataKey;
  const IsTouchedCanvasElement({
    Key? key,
    required this.controller,
    // required this.element,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<IsTouchedCanvasElement> createState() => _IsTouchedCanvasElementState();
}

class _IsTouchedCanvasElementState extends State<IsTouchedCanvasElement> {
  @override
  void initState() {
    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .setCode(mainFunctionCode: '''
      messaging.send('p0'+str(p0.is_touched()))
      messaging.send('p1'+str(p1.is_touched()))
      messaging.send('p2'+str(p2.is_touched()))
''');

    widget.controller.creatorData.currentCanvasElements[widget.elementDataKey]!
        .optionsMenuData = OptionsMenuData(
      hasColorPicker: true,
      hasTextInput: true,
      hasPinPicker: true,
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
        return IsTouchedElement(
          data: data,
          isPressedDown: isPressedDown,
          controller: widget.controller,
        );
      },
    );
  }
}
