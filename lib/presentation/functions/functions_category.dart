import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:codeit_creator/presentation/functions/elements/output_function_element.dart';
import 'package:codeit_creator/presentation/functions/elements/output_function_with_parameter_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/output_function_canvas_element.dart';
export './elements/output_function_with_parameter_canvas_element.dart';

class FunctionsCreatorCategory extends StatelessWidget {
  final CreatorController controller;

  const FunctionsCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorConsts.getLocale(context)!.functions,
      color: CreatorConsts.creatorFunctionsColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Functions,
          child: OutputFunctionElement(),
          label: "Output Function",
          color: CreatorConsts.creatorFunctionsColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Functions,
          child: OutputFunctionWithParameterElement(),
          label: "Output Function With Parameter",
          color: CreatorConsts.creatorFunctionsColor,
          controller: controller,
          totalInputs: 1,
          totalOutputs: 0,
        ),
      ],
      category: CreatorCategoryType.Functions,
    );
  }
}
