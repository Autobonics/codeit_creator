import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/creator_element_knob.dart';
import 'package:codeit_creator/presentation/routes.dart';
import 'package:flutter/material.dart';

class CreatorCanvasElement extends StatefulWidget {
  ///if optionsMenuData is null, options menu will not be shown.
  // final CreatorElementData data;
  final double defaultSize;
  final CreatorController controller;
  final Widget Function(CreatorElementData data, bool isPressedDown)
      childBuilder;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final String elementDataKey;
  const CreatorCanvasElement({
    Key? key,
    // required this.data,
    required this.childBuilder,
    required this.controller,
    this.defaultSize = 100,
    this.onTapDown,
    this.onTapUp,
    required this.elementDataKey,
  }) : super(key: key);

  @override
  State<CreatorCanvasElement> createState() => _CreatorCanvasElementState();
}

class _CreatorCanvasElementState extends State<CreatorCanvasElement> {
  Offset? startPos;
  bool isDown = false;
  late CreatorElementData data;

  _listener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    data = widget
        .controller.creatorData.currentCanvasElements[widget.elementDataKey]!;
    if (data.size == null) data.update(size: widget.defaultSize);
    data.addListener(_listener);
  }

  @override
  void dispose() {
    data.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    bool isArabic = Localizations.localeOf(context) == Locale('ar');
    return Positioned(
      left: data.position.dx,
      top: data.position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          if (!widget.controller.isEditMode.value) {
            Routes.showSnackBar(context, 'Stop running the code to edit!');
            return;
          }
          startPos = details.localPosition;
        },
        onPanUpdate: widget.controller.isEditMode.value
            ? (details) {
                widget.controller.isOptionsMenuVisible.value = false;
                widget.controller.isDrawerOpen.value = false;
                Offset globalPos = details.globalPosition;
                Offset toUpdate = Offset(
                    globalPos.dx - startPos!.dx, globalPos.dy - startPos!.dy);
                data.update(position: toUpdate);
                setState(() {});
                if ((isArabic
                        ? globalPos.dx > totalWidth - 50
                        : globalPos.dx < 50) &&
                    (totalHeight - globalPos.dy) < 100) {
                  widget.controller.hasTrashBin.value = true;
                } else {
                  widget.controller.hasTrashBin.value = false;
                }
              }
            : null,
        onPanEnd: widget.controller.isEditMode.value
            ? (details) {
                if (widget.controller.hasTrashBin.value) {
                  widget.controller.creatorData
                      .removeCanvasElement(widget.elementDataKey);
                  widget.controller.hasTrashBin.value = false;
                }
              }
            : null,
        onTapDown: (details) {
          if (widget.onTapDown == null) return;
          isDown = true;
          setState(() {});
          widget.onTapDown!.call();
        },
        onTapUp: (details) {
          if (widget.onTapUp != null) {
            isDown = false;
            setState(() {});
            widget.onTapUp!.call();
          }
          if (!widget.controller.isEditMode.value) {
            if (widget.onTapUp == null)
              Routes.showSnackBar(context, 'Stop running the code to edit!');
            return;
          }
          if (widget.controller.isOptionsMenuVisible.value) {
            widget.controller.isOptionsMenuVisible.value = false;
            return;
          }
          if (data.optionsMenuData == null) return;
          if (widget.controller.isDrawerOpen.value)
            widget.controller.isDrawerOpen.value = false;
          double currentX = details.globalPosition.dx;
          double currentY = details.globalPosition.dy;
          if ((totalWidth - currentX) < 290)
            currentX -= (290 - (totalWidth - currentX));
          if ((totalHeight - currentY) < 260)
            currentY -= (260 - (totalHeight - currentY));
          data.optionsMenuData!.position = Offset(currentX, currentY);
          widget.controller.currentSelectedElement = data;
          widget.controller.isOptionsMenuVisible.value = false;
          widget.controller.isOptionsMenuVisible.value = true;
        },
        child: Row(
          children: [
            if (widget.controller.isAiMode.value)
              Column(
                children: [
                  for (GlobalKey key in data.inputGlobalKeys)
                    CurveInputKnob(key: key)
                ],
              ),
            Column(
              children: [
                widget.childBuilder(data, isDown),
                if (data.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
              ],
            ),
            if (widget.controller.isAiMode.value)
              Column(
                children: [
                  for (int i = 0; i < data.outputGlobalKeys.length; i++)
                    CurveOutputKnob(
                      key: data.outputGlobalKeys[i],
                      elementKey: widget.elementDataKey,
                      data: widget.controller.creatorData
                          .currentCanvasElements[widget.elementDataKey]!,
                      knobIndex: i,
                      controller: widget.controller,
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
