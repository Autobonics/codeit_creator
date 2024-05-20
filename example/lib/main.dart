import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:codeit_creator/presentation/Rotate/elements/setAngle_element.dart';
import 'package:codeit_creator/presentation/codeit_creator.dart';
import 'package:codeit_creator/presentation/move/elements/move_element.dart';
import 'package:codeit_creator/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 200,
              child: SetAngleElement(
                defaultSize: 200,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: MoveElement(
                defaultSize: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
