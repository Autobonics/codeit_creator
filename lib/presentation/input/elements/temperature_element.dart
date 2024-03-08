import 'dart:async';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class TemperatureElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const TemperatureElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<TemperatureElement> createState() => _TemperatureElementState();
}

class _TemperatureElementState extends State<TemperatureElement> {
  String temperature = '0';
  StreamSubscription? subscription;

  _onMessage(String msg) {
    if (msg[0] != 't') return;
    temperature = msg.substring(1);
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    subscription =
        widget.controller?.viewModel.messageStream?.listen(_onMessage);
    widget.data?.creatorAiData?.function = (val) {
      return temperature;
    };
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.data?.color ?? CreatorConsts.creatorInputColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black38, blurRadius: widget.isPressedDown ? 10 : 20)
        ],
      ),
      width: widget.data?.size ?? widget.defaultSize,
      height: widget.data?.size ?? widget.defaultSize,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.data != null)
                  Text(
                    CreatorConsts.getLocale(context)!.currentTemp,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                Text(
                  "$temperature °C",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
