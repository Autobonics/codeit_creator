import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/presentation/Music/elements/piano_element.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/presentation/creator_category.dart';
import 'package:codeit_creator/presentation/creator_category_element.dart';
import 'package:flutter/cupertino.dart';

export './elements/piano_canvas_element.dart';

class MusicCreatorCategory extends StatelessWidget {
  final CreatorControllerBase controller;

  const MusicCreatorCategory({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreatorCategory(
      controller: controller,
      categoryName: CreatorConsts.getLocale(context)!.music,
      color: CreatorConsts.creatorMusicColor,
      elements: [
        SizedBox(height: 20),
        CreatorCategoryElement(
          category: CreatorCategoryType.Music,
          child: PianoElement(),
          label: "Piano",
          color: CreatorConsts.creatorMusicColor,
          controller: controller,
          totalInputs: 0,
          totalOutputs: 0,
        ),
      ],
      category: CreatorCategoryType.Music,
    );
  }
}
