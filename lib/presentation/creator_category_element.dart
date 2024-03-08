import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

class CreatorCategoryElement extends StatefulWidget {
  final CreatorCategoryType category;
  final Widget child;
  final String label;
  final SizedBox spaceBetween;
  final int totalInputs;
  final int totalOutputs;

  final Color color;
  final CreatorController controller;
  const CreatorCategoryElement({
    Key? key,
    required this.category,
    required this.child,
    required this.label,
    required this.color,
    required this.controller,
    this.totalInputs = 1,
    this.totalOutputs = 1,
    this.spaceBetween = const SizedBox(height: 4),
  }) : super(key: key);

  @override
  State<CreatorCategoryElement> createState() => _CreatorCategoryElementState();
}

class _CreatorCategoryElementState extends State<CreatorCategoryElement> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      child: Column(
        children: [
          Text(
            CreatorElementData.getLabelName(
                label: widget.label, context: context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          widget.spaceBetween,
          widget.child,
        ],
      ),
    );

    return Draggable<CreatorElementData>(
      feedback: widget.child,
      data: CreatorElementData(
        label: widget.label,
        inputCount: widget.totalInputs,
        outputCount: widget.totalOutputs,
        categoryType: widget.category,
      ),
      onDragStarted: () => widget.controller.isDrawerOpen.value = false,
      child: child,
    );
  }
}
