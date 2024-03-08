import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/text/elements/text_element.dart';
import 'package:flutter/src/widgets/framework.dart';

class BonicTextElement extends StatelessWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;

  const BonicTextElement(
      {Key? key, this.data, this.isPressedDown = false, this.defaultSize = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextElement(
      fontFamily: 'Anita',
      defaultSize: this.defaultSize,
      data: this.data,
      isPressedDown: isPressedDown,
    );
  }
}

class HeadingTextElement extends StatelessWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  const HeadingTextElement(
      {Key? key, this.data, this.isPressedDown = false, this.defaultSize = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextElement(
      fontFamily: 'Agent',
      defaultSize: this.defaultSize,
      data: this.data,
      isPressedDown: isPressedDown,
    );
  }
}

class SubHeadingElement extends StatelessWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  const SubHeadingElement(
      {Key? key, this.data, this.isPressedDown = false, this.defaultSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextElement(
      defaultSize: this.defaultSize,
      data: this.data,
      isPressedDown: isPressedDown,
    );
  }
}

class BodyTextElement extends StatelessWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  const BodyTextElement(
      {Key? key, this.data, this.isPressedDown = false, this.defaultSize = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextElement(
      fontFamily: 'Poppins',
      defaultSize: this.defaultSize,
      data: this.data,
      isPressedDown: isPressedDown,
    );
  }
}
