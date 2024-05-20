import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/Display/elements/scroll_element.dart';
import 'package:codeit_creator/presentation/Display/elements/setPixel_element.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/scroll_canvas_element.dart';
export './elements/setPixel_canvas_element.dart';

class DisplayCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;

  const DisplayCreatorCategory({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: controller.getLabelName(label: 'display', context: context),
      color: CreatorConsts.creatorDisplayColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Display,
          child: SetPixelElement(),
          label: "Set Pixel",
          color: CreatorConsts.creatorDisplayColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Display,
          child: ScrollElement(),
          label: "Scroll",
          color: CreatorConsts.creatorDisplayColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
      ],
      category: CreatorCategoryType.Display,
    );
  }
}
