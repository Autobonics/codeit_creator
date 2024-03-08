import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/button/elements/is_pressed_element.dart';
import 'package:codeit_creator/presentation/button/elements/is_touched_element.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/is_pressed_canvas_element.dart';
export './elements/is_touched_canvas_element.dart';

class ButtonCreatorCategory extends StatelessWidget {
  final CreatorController controller;

  const ButtonCreatorCategory({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorConsts.getLocale(context)!.button,
      color: CreatorConsts.creatorButtonColor,
      elements: [
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Button,
          label: "Is Pressed",
          color: CreatorConsts.creatorButtonColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: const IsPressedElement(),
        ),
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Button,
          label: "Is Touched",
          color: CreatorConsts.creatorButtonColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: const IsTouchedElement(),
        ),
      ],
      category: CreatorCategoryType.Button,
    );
  }
}
