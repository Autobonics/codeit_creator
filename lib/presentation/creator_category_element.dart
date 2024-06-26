import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/codeit_creator.dart';
import 'package:flutter/material.dart';

class CreatorCategoryElement extends StatefulWidget {
  final CreatorCategoryType category;
  final Widget child;
  final String label;
  final SizedBox spaceBetween;
  final int totalInputs;
  final int totalOutputs;

  final Color color;
  final CreatorControllerBase controller;
  const CreatorCategoryElement({
    super.key,
    required this.category,
    required this.child,
    required this.label,
    required this.color,
    required this.controller,
    this.totalInputs = 1,
    this.totalOutputs = 1,
    this.spaceBetween = const SizedBox(height: 4),
  });

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
            widget.controller
                .getLabelName(label: widget.label, context: context),
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
