import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/ai/elements/gpt_element.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:flutter/cupertino.dart';

class AiCreatorCategory extends StatelessWidget {
  final CreatorController controller;

  const AiCreatorCategory({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: 'AI',
      color: CreatorConsts.creatorAiColor,
      elements: [
        const SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.AI,
          label: "Generative AI",
          color: CreatorConsts.creatorAiColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 1,
          child: const GptElement(),
        ),
        const SizedBox(height: 20),
      ],
      category: CreatorCategoryType.AI,
    );
  }
}
