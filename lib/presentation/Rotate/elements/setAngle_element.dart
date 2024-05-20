import 'dart:math';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class SetAngleElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const SetAngleElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<SetAngleElement> createState() => _SetAngleElementState();
}

class _SetAngleElementState extends State<SetAngleElement> {
  int currentAngle = 90;
  bool isProcessing = false;

  _listner() {
    if (!mounted) return;
    setState(() {});
    if (widget.data?.port != null) {
      setFunctionData(widget.data!.port!);
    }
  }

  setFunctionData(int port) {
    widget.data!.creatorAiData!.gptFunctionData = GptFunctionData(
      name: "set_angle_at_port_$port",
      hasParameter: true,
      description:
          '''This funciton is called to set the specified angle to the servo module connected at port $port of bonic brain.
          The function must be called with the angle as parameter. 
          The angle must be a number from 0 to 180''',
      parameters: {
        "type": "object",
        "properties": {
          "angle": {
            "type": "integer",
            "description":
                "An integer number value between 0 to 180 to be set as the angle of the servo."
          }
        },
        "required": ["angle"]
      },
    );
  }

  String _onAngle(Map? data) {
    if (data == null) return 'The input parameter is invalid';
    if (isProcessing) return 'Still processing from the previous call';
    isProcessing = true;
    setState(() {});
    String sdata = data['angle'].toString();
    int? angle = int.tryParse(sdata);
    if (angle != null) currentAngle = angle;
    if (sdata.length > 9) sdata = sdata.substring(0, 9);
    widget.controller?.viewModel.sendMessage('&${widget.data?.port}$sdata');
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      isProcessing = false;
      setState(() {});
    });
    return 'The data has been sent to the servo module';
  }

  @override
  void initState() {
    widget.data?.addListener(_listner);
    currentAngle = widget.data?.widgetData['currentAngle'] ?? 90;
    if (widget.data?.port != null) {
      setFunctionData(widget.data!.port!);
    }
    widget.data?.creatorAiData!.function = _onAngle;
    super.initState();
  }

  @override
  void dispose() {
    widget.data?.removeListener(_listner);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;

    _getSlider() {
      return Container(
        height: size * 0.2,
        width: size * 1.25,
        child: Slider(
          onChangeEnd: (value) {
            widget.controller?.viewModel
                .sendMessage('&${widget.data?.port}$currentAngle');
            widget.data?.widgetData['currentAngle'] = currentAngle;
          },
          thumbColor: Colors.white,
          activeColor: Colors.white70,
          inactiveColor: Colors.white38,
          onChanged: (double value) {
            currentAngle = value.toInt();
            setState(() {});
          },
          value: currentAngle.toDouble(),
          min: 0,
          max: 180,
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.data?.color ?? CreatorConsts.creatorRotateColor,
        ),
        height: size,
        width: size * 1.25,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!isProcessing)
              Transform.rotate(
                alignment: Alignment.bottomCenter,
                angle: (pi / 180) * currentAngle - pi / 2,
                child: Container(
                  height: size * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "packages/codeit_creator/assets/creator/rotate/servo_arm.png"),
                    ),
                  ),
                ),
              ),
            if (isProcessing) Center(child: CircularProgressIndicator()),
            Positioned(
              top: size / 4,
              left: size / 2 + size * 0.07,
              child: Text(
                currentAngle.toString() + '°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.1,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: _getSlider(),
            ),
          ],
        ),
      ),
    );
  }
}
