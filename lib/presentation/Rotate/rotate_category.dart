import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/Rotate/elements/setAngle_element.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/setAngle_canvas_element.dart';

class RotateCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;

  const RotateCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName:
          CreatorControllerBase.getLabelName(label: 'rotate', context: context),
      color: CreatorConsts.creatorRotateColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Rotate,
          child: SetAngleElement(),
          label: "Set Angle",
          color: CreatorConsts.creatorRotateColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
        // SizedBox(height: 20),
        // CreatorCategoryElement(
        //   category: CreatorCategoryType.Display,
        //   child: StopElement(),
        //   label: "Stop",
        //   color: CreatorConsts.creatorDisplayColor,
        //   controller: controller,
        // ),
      ],
      category: CreatorCategoryType.Rotate,
    );
  }
}
