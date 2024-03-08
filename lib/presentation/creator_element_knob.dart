import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CurveInputKnob extends StatelessWidget {
  const CurveInputKnob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

class CurveOutputKnob extends StatefulWidget {
  final CreatorControllerBase controller;
  final CreatorElementData data;
  final String elementKey;
  final int knobIndex;
  final GlobalKey key;
  const CurveOutputKnob({
    required this.key,
    required this.controller,
    required this.data,
    required this.knobIndex,
    required this.elementKey,
  }) : super(key: key);

  @override
  State<CurveOutputKnob> createState() => _CurveOutputKnobState();
}

class _CurveOutputKnobState extends State<CurveOutputKnob> {
  Offset? curveStartPos;
  Offset? curveEndPos;

  @override
  Widget build(BuildContext context) {
    // print("The current global key is ${widget.key}");

    _getGesture(Widget child) {
      return GestureDetector(
        onPanStart: (details) {
          if (!widget.controller.isEditMode.value) {
            Routes.showSnackBar(context, 'Stop running the code to edit!');
            return;
          }
          RenderBox obj =
              widget.key.currentContext?.findRenderObject() as RenderBox;
          curveStartPos = obj
              .localToGlobal(Offset(obj.size.width / 2, obj.size.height / 2));
          curveEndPos = details.globalPosition;
          widget.controller.temperaryCurve = [curveStartPos!, curveEndPos!];
          widget.controller.updatePainter?.call();
        },
        onPanUpdate: !widget.controller.isEditMode.value
            ? null
            : (details) {
                curveEndPos = details.globalPosition;
                widget.controller.temperaryCurve = [
                  curveStartPos!,
                  curveEndPos!
                ];
                widget.controller.updatePainter?.call();
              },
        onPanEnd: !widget.controller.isEditMode.value
            ? null
            : (details) {
                widget.controller.temperaryCurve = [];

                for (String elementKey in widget
                    .controller.creatorData.currentCanvasElements.keys) {
                  CreatorElementData iterData = widget.controller.creatorData
                      .currentCanvasElements[elementKey]!;
                  bool hasFound = false;
                  for (int knobIndex = 0;
                      knobIndex < iterData.inputGlobalKeys.length;
                      knobIndex++) {
                    GlobalKey inputKey = iterData.inputGlobalKeys[knobIndex];
                    if (widget.data.inputGlobalKeys.contains(inputKey))
                      continue;
                    RenderBox? obj = inputKey.currentContext?.findRenderObject()
                        as RenderBox;
                    if (obj.hitTest(
                      BoxHitTestResult(),
                      position: obj.globalToLocal(curveEndPos!),
                    )) {
                      hasFound = true;
                      // String dataString =
                      //     "${widget.elementIndex}${widget.knobIndex}${elementIndex}${knobIndex}";
                      CreatorElementConnection connection =
                          CreatorElementConnection(
                        firstElementId: widget.elementKey,
                        outputKnobIndex: widget.knobIndex,
                        secondElementId: elementKey,
                        inputKnobIndex: knobIndex,
                      );
                      if (widget.controller.creatorData.curveConnections
                          .contains(connection)) {
                        widget.controller.creatorData.curveConnections
                            .remove(connection);
                        widget
                            .controller
                            .creatorData
                            .currentCanvasElements[widget.elementKey]!
                            .currentOutputDataKeys
                            .remove(elementKey);
                        widget
                            .controller
                            .creatorData
                            .currentCanvasElements[elementKey]!
                            .currentInputDataKeys
                            .remove(widget.elementKey);
                      } else {
                        widget.controller.creatorData.curveConnections
                            .add(connection);
                        widget
                            .controller
                            .creatorData
                            .currentCanvasElements[widget.elementKey]!
                            .currentOutputDataKeys
                            .add(elementKey);
                        widget
                            .controller
                            .creatorData
                            .currentCanvasElements[elementKey]!
                            .currentInputDataKeys
                            .add(widget.elementKey);
                      }
                    }
                  }
                  if (hasFound) break;
                }
                widget.controller.updatePainter?.call();
              },
        child: child,
      );
    }

    Widget _child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.7,
                color: Colors.white,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );

    return _getGesture(_child);
  }
}
