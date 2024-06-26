import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/input/elements/distance_element.dart';
import 'package:codeit_creator/presentation/input/elements/temperature_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/distance_canvas_element.dart';
export './elements/temperature_canvas_element.dart';

class InputCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;

  const InputCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: controller.getLabelName(label: 'input', context: context),
      color: CreatorConsts.creatorInputColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Input,
          child: DistanceElement(),
          label: "Distance",
          color: CreatorConsts.creatorInputColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 1,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Input,
          child: TemperatureElement(),
          label: "Temperature",
          color: CreatorConsts.creatorInputColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 1,
        ),
      ],
      category: CreatorCategoryType.Input,
    );
  }
}
