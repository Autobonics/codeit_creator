import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/movement/elements/orientation_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/oreintation_canvas_element.dart';

class MovementCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;

  const MovementCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorControllerBase.getLabelName(
          label: 'orientation', context: context),
      color: CreatorConsts.creatorMovementColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Movement,
          child: OrientationElement(),
          label: "Orientation",
          color: CreatorConsts.creatorMovementColor,
          controller: controller,
          spaceBetween: SizedBox(height: 50),
          totalInputs: 0,
          totalOutputs: 1,
        )
      ],
      category: CreatorCategoryType.Movement,
    );
  }
}
