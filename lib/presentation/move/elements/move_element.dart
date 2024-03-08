import 'package:codeit_creator/presentation/move/elements/move_canvas_element.dart';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

// enum MoveIcon {
//   ArrowForward,
//   ArrowReverse,
//   RotateClockwise,
//   RotateAnitClockwise
// }

class MoveElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorController? controller;

  const MoveElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<MoveElement> createState() => _MoveElementState();
}

class _MoveElementState extends State<MoveElement> {
  bool isProcessing = false;

  setFunctionData(int port, MoveDirection direction) {
    widget.data!.creatorAiData!.gptFunctionData = GptFunctionData(
      name: "move_${direction.name}_at_port_$port",
      description:
          '''This funciton is called to rotate the motor in ${direction.name} direction of the 'Move' module connected at port $port of bonic brain.''',
      hasParameter: false,
      parameters: {
        "type": "object",
        "properties": {
          "dummy_property": {
            "type": "null",
          }
        },
      },
    );
  }

  String _onMove(Map? data) {
    if (isProcessing) return 'Still processing from the previous call';
    isProcessing = true;
    setState(() {});
    int port = widget.data!.port!;
    String dir =
        widget.data!.moveDirection! == MoveDirection.Clockwise ? '!' : '"';
    widget.controller?.viewModel.sendMessage('${dir}${port}');
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      isProcessing = false;
      setState(() {});
    });
    return 'The data has been sent to the move module';
  }

  _listner() {
    if (!mounted) return;
    setState(() {});
    if (widget.data?.port != null && widget.data?.moveDirection != null) {
      setFunctionData(
        widget.data!.port!,
        widget.data!.moveDirection!,
      );
    }
  }

  @override
  void initState() {
    widget.data?.addListener(_listner);
    if (widget.data?.port != null && widget.data?.moveDirection != null) {
      setFunctionData(
        widget.data!.port!,
        widget.data!.moveDirection!,
      );
    }
    widget.data?.creatorAiData!.function = _onMove;
    super.initState();
  }

  @override
  void dispose() {
    widget.data?.removeListener(_listner);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.data?.color ?? CreatorConsts.creatorMoveColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black38, blurRadius: widget.isPressedDown ? 10 : 20)
        ],
      ),
      width: widget.data?.size ?? widget.defaultSize,
      height: widget.data?.size ?? widget.defaultSize,
      child: Center(
        child: Icon(
          widget.data?.moveDirection == MoveDirection.AntiClockwise
              ? Icons.rotate_left
              : Icons.rotate_right,
          size: (widget.data?.size ?? widget.defaultSize) * 0.35,
          color: CreatorConsts.outputModuleColor,
        ),
      ),
    );
  }
}
