import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class StopElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const StopElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<StopElement> createState() => _StopElementState();
}

class _StopElementState extends State<StopElement> {
  bool isProcessing = false;

  setFunctionData(int port) {
    widget.data!.creatorAiData!.gptFunctionData = GptFunctionData(
      name: "stop_move_at_port_$port",
      description:
          '''This funciton is called to stop the motor of the 'Move' module connected at port $port of bonic brain.''',
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
    widget.controller?.viewModel.sendMessage('#${port}');
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      isProcessing = false;
      setState(() {});
    });
    return 'The data has been sent to the move module';
  }

  _listner() {
    if (!mounted) return;
    setState(() {});
    if (widget.data?.port != null) {
      setFunctionData(widget.data!.port!);
    }
  }

  @override
  void initState() {
    widget.data?.addListener(_listner);
    if (widget.data?.port != null) {
      setFunctionData(widget.data!.port!);
    }
    widget.data?.creatorAiData!.function = _onMove;
    super.initState();
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
          Icons.front_hand,
          size: (widget.data?.size ?? widget.defaultSize) * 0.5,
          color: Colors.red,
        ),
      ),
    );
  }
}
