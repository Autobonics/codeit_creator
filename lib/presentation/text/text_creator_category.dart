import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/text/elements/text_elements.dart';
import 'package:flutter/material.dart';

class TextCreatorCategory extends StatelessWidget {
  final CreatorController controller;
  const TextCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorConsts.getLocale(context)!.text,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          child: BonicTextElement(),
          label: "Bonic",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          child: HeadingTextElement(),
          label: "Heading",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          child: SubHeadingElement(),
          label: "Sub Heading",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Text,
          child: BodyTextElement(),
          label: "Body",
          color: CreatorConsts.creatorTextColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
      ],
      category: CreatorCategoryType.Text,
      color: CreatorConsts.creatorTextColor,
    );
  }
}
