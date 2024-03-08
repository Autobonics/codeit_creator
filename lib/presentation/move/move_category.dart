import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/move/elements/move_element.dart';
import 'package:codeit_creator/presentation/move/elements/stop_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/move_canvas_element.dart';
export './elements/stop_canvas_element.dart';

class MoveCreatorCategory extends StatelessWidget {
  final CreatorController controller;

  const MoveCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorConsts.getLocale(context)!.move,
      color: CreatorConsts.creatorMoveColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Move,
          child: MoveElement(),
          label: "Move",
          color: CreatorConsts.creatorMoveColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Move,
          child: StopElement(),
          label: "Stop",
          color: CreatorConsts.creatorMoveColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
      ],
      category: CreatorCategoryType.Move,
    );
  }
}
