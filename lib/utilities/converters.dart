import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/move/elements/move_canvas_element.dart';
import 'package:flutter/material.dart';

class Converters {
  static Color? colorFromString(String? colorString) {
    if (colorString == null) return null;
    List<String> colorVals = colorString.split('-');
    return Color.fromARGB(
      int.parse(colorVals[0]),
      int.parse(colorVals[1]),
      int.parse(colorVals[2]),
      int.parse(colorVals[3]),
    );
  }

  static String? colorToString(Color? color) {
    if (color == null) return null;
    return '${color.alpha}-${color.red}-${color.green}-${color.blue}';
  }

  static Offset? offsetFromString(String? offsetString) {
    if (offsetString == null) return null;
    List<String> cords = offsetString.split(',');
    return Offset(double.parse(cords[0]), double.parse(cords[1]));
  }

  static String? offsetToString(Offset? offset) {
    if (offset == null) return null;
    return '${offset.dx},${offset.dy}';
  }

  static MoveDirection? directionFromString(String? spinDirection) {
    if (spinDirection == null) return null;
    if (spinDirection == MoveDirection.AntiClockwise.name)
      return MoveDirection.AntiClockwise;
    return MoveDirection.Clockwise;
  }

  static String? directionToString(MoveDirection? direction) {
    return direction?.name;
  }

  static CreatorCategoryType categoryTypeFromString(String categoryType) {
    for (CreatorCategoryType type in CreatorCategoryType.values) {
      if (type.name == categoryType) {
        return type;
      }
    }
    return CreatorCategoryType.AI;
  }

  static FunctionProgrammingPlatform? programmingPlatfromTypeFromString(
      String? programmingPlatform) {
    if (programmingPlatform == null) return null;
    for (FunctionProgrammingPlatform platform
        in FunctionProgrammingPlatform.values) {
      if (platform.name == programmingPlatform) {
        return platform;
      }
    }
    return null;
  }

  // static IconData iconFromMoveIcon(MoveIcon moveIcon) {
  //   switch (moveIcon) {
  //     case MoveIcon.ArrowForward:
  //       return Icons.arrow_drop_up;
  //     case MoveIcon.ArrowReverse:
  //       return Icons.arrow_drop_down;
  //     case MoveIcon.RotateClockwise:
  //       return Icons.rotate_right;
  //     case MoveIcon.RotateAnitClockwise:
  //       return Icons.rotate_left;
  //   }
  // }

  // static MoveIcon? iconFromString(String iconString) {
  //   for (MoveIcon icon in MoveIcon.values) {
  //     if (icon.name == iconString) return icon;
  //   }
  //   return null;
  // }

  // static String? stringFromIcon(MoveIcon icon) {
  //   return icon.name;
  // }
}
