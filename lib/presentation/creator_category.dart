import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:flutter/material.dart';

// class CreatorCategoryBase extends StatefulWidget {
//   final Widget creatorCategory;
//   final CreatorController controller;

//   const CreatorCategoryBase({
//     super.key,
//     required this.controller,
//     required this.creatorCategory,
//   });

//   @override
//   State<CreatorCategoryBase> createState() => _CreatorCategoryBaseState();
// }

// class _CreatorCategoryBaseState extends State<CreatorCategoryBase> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: widget.creatorCategory,
//       onTap: () {
//         widget.controller.currentCategoryElements.value = widget.elements;
//         widget.controller.currentSelectedCategory.value == widget.category
//             ? widget.controller.currentSelectedCategory.value =
//                 CreatorCategoryType.None
//             : widget.controller.currentSelectedCategory.value = widget.category;
//       },
//     );
//   }
// }

class CreatorCategory extends StatefulWidget {
  final String categoryName;
  final List<Widget> elements;
  final CreatorCategoryType category;
  final CreatorControllerBase controller;
  final Color color;
  const CreatorCategory({
    Key? key,
    required this.controller,
    required this.categoryName,
    required this.elements,
    required this.category,
    required this.color,
  }) : super(key: key);

  @override
  State<CreatorCategory> createState() => _CreatorCategoryState();
}

class _CreatorCategoryState extends State<CreatorCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.controller.currentCategoryElements.value = widget.elements;
        widget.controller.currentSelectedCategory.value == widget.category
            ? widget.controller.currentSelectedCategory.value =
                CreatorCategoryType.None
            : widget.controller.currentSelectedCategory.value = widget.category;
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
              widget.controller.currentSelectedCategory.value == widget.category
                  ? Colors.black12
                  : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image.asset(
            //   'assets/beginner/Move.png',
            //   scale: 5,
            // ),
            Container(
              alignment: Alignment.centerLeft,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
                color: widget.color,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              width: 20,
            ),
            Text(
              widget.categoryName,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
