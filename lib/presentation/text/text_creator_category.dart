import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/material.dart';

export './elements/body_canvas_element.dart';
export './elements/bonic_canvas_element.dart';
export './elements/heading_canvas_element.dart';
export './elements/subheading_canvas_element.dart';

class TextCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;
  const TextCreatorCategory({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName:
          CreatorControllerBase.getLabelName(label: 'text', context: context),
      elements: [
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          label: "Bonic",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: const BonicTextElement(),
        ),
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          label: "Heading",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: const HeadingTextElement(),
        ),
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          label: "Sub Heading",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: const SubHeadingElement(),
        ),
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          label: "Body",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
          child: BodyTextElement(),
        ),
      ],
      category: CreatorCategoryType.Text,
      color: CreatorConsts.creatorTextColor,
    );
  }
}
