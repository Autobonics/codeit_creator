import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';

///This file will be modified base on updates given to backend logic of codeit.

abstract class CreatorViewModelBase {
  late List<dynamic> Function(
    String, {
    Map<String, String>? continousMessages,
    List? generatedCodes,
  }) playCode;
  late void Function() stopCode;
  late final void Function(String code, String locationName) saveFileData;
  late final Future<String> Function(String locationName) loadFileData;
  late final Future<bool> Function(String locationName) deleteFileData;
  late final Future<List> Function() loadFileNames;
  late Future<String?> Function({
    required String text,
    List<CreatorAiData>? datas,
    List<Messages>? messages,
    StreamController<String>? chatCompletionStream,
  }) chatComplete;

  bool get hasData;

  Stream<String>? get messageStream;

  void sendMessage(String message);

  Future<CreatorData?> loadCreatorData();

  Future<bool> saveCreatorData(CreatorData data);

  Future<void> textToSpeech(String text);

  Future<void> stopTextToSpeech();
}

abstract class CreatorControllerBase {
  late CreatorViewModelBase viewModel;

  CreatorControllerBase();

  final ValueNotifier<bool> isEditMode = ValueNotifier<bool>(true);

  final ValueNotifier<bool> isDrawerOpen = ValueNotifier<bool>(true);

  final ValueNotifier<CreatorCategoryType> currentSelectedCategory =
      ValueNotifier(CreatorCategoryType.None);

  final ValueNotifier<List<Widget>> currentCategoryElements =
      ValueNotifier<List<Widget>>([]);

  CreatorData creatorData = CreatorData(
    currentCanvasElements: {},
    curveConnections: {},
    isAiMode: false,
    customFunctionElementsWithCode: {},
  );

  //[point1, point2]
  List<Offset> temperaryCurve = [];

  VoidCallback? updatePainter;

  final ValueNotifier<bool> isAiMode = ValueNotifier<bool>(false);

  final ValueNotifier<bool> hasTrashBin = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isOptionsMenuVisible = ValueNotifier<bool>(false);
  CreatorElementData? currentSelectedElement = null;

  String generateCode();

  String? checkError();
}
