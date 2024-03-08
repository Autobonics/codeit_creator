import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class TextElement extends StatelessWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final String? fontFamily;

  const TextElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 22,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        data?.text ?? 'Text',
        style: TextStyle(
          fontSize: data?.size ?? defaultSize,
          color: data?.color ?? CreatorConsts.creatorTextColor,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
