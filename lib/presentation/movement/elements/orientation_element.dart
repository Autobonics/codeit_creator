import 'dart:async';
import 'package:codeit_creator/presentation/movement/elements/bonic_3d.dart';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class OrientationElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const OrientationElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 75,
    this.controller,
  }) : super(key: key);

  @override
  State<OrientationElement> createState() => _OrientationElementState();
}

class _OrientationElementState extends State<OrientationElement> {
  List<int> angles = [40, 40];
  StreamSubscription? subscription;

  _onMessage(String msg) {
    if (msg[0] != 'o') return;
    String angleString = msg.substring(1);
    angles = angleString.split(',').map((e) => int.parse(e)).toList();
    _listner();
  }

  _listner() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    subscription =
        widget.controller?.viewModel.messageStream?.listen(_onMessage);
    widget.data?.addListener(_listner);
    widget.data?.creatorAiData?.function = (val) {
      return 'x: ${angles[0]}, y: ${angles[1]}';
    };
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    widget.data?.removeListener(_listner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;

    // return Container();
    return Material(
      color: Colors.transparent,
      child: Bonic3D(
        rotateX: -angles[0].toDouble(),
        rotateY: angles[1].toDouble(),
        size: size,
        mainColor: widget.data?.color ?? CreatorConsts.creatorMovementColor,
      ),
    );
  }
}
