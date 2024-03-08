import 'dart:math';

import 'package:codeit_creator/data/creator_element_data.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CreatorCategoryType {
  None,
  Move,
  Text,
  Input,
  Display,
  Music,
  Rotate,
  Movement,
  Button,
  AI,
  Functions,
}

class CreatorData {
  final Map<String, CreatorElementData> _currentCanvasElements;
  final Set<CreatorElementConnection> _curveConnections;
  final bool isAiMode;
  //key: canvasElementMapKey, value: code
  final Map<String, String> _customFunctionElementsWithCode;

  CreatorData({
    required Map<String, CreatorElementData> currentCanvasElements,
    required Set<CreatorElementConnection> curveConnections,
    required this.isAiMode,
    required Map<String, String> customFunctionElementsWithCode,
  })  : _currentCanvasElements = currentCanvasElements,
        _curveConnections = curveConnections,
        _customFunctionElementsWithCode = customFunctionElementsWithCode;

  Map<String, CreatorElementData> get currentCanvasElements =>
      _currentCanvasElements;
  Set<CreatorElementConnection> get curveConnections => _curveConnections;

  Map<String, String> get customFunctionElementsWithCode =>
      _customFunctionElementsWithCode;

  Map toMap() {
    return {
      'currentCanvasElements': _currentCanvasElements
          .map((key, value) => MapEntry(key.toString(), value.toMap())),
      'curveConnections': _curveConnections.map((e) => e.toMap()).toList(),
      'isAiMode': isAiMode,
      'customFunctionElementsWithCode': customFunctionElementsWithCode,
    };
  }

  factory CreatorData.fromMap(Map map) {
    Map<String, CreatorElementData> data = (map['currentCanvasElements'])
        .map<String, CreatorElementData>((key, value) =>
            MapEntry(key.toString(), CreatorElementData.fromMap(value)));

    Set<CreatorElementConnection> connections =
        (map['curveConnections'] as List)
            .map((e) => CreatorElementConnection.fromMap(e))
            .toSet();

    Map<String, String> customFunctions =
        (map['customFunctionElementsWithCode']).map<String, String>(
            (key, value) => MapEntry(key as String, value as String));

    return CreatorData(
      currentCanvasElements: data,
      curveConnections: connections,
      isAiMode: map['isAiMode'],
      customFunctionElementsWithCode: customFunctions,
    );
  }

  CreatorData update({bool? isAiMode}) {
    return CreatorData(
      currentCanvasElements: currentCanvasElements,
      curveConnections: curveConnections,
      isAiMode: isAiMode ?? this.isAiMode,
      customFunctionElementsWithCode: customFunctionElementsWithCode,
    );
  }

  void clear() {
    _currentCanvasElements.clear();
    _curveConnections.clear();
    customFunctionElementsWithCode.clear();
  }

  void addCanvasElement(CreatorElementData data) {
    String key = UniqueKey().hashCode.toString();
    if (data.categoryType == CreatorCategoryType.Functions) {
      final random = Random();
      String getCode() => String.fromCharCode(random.nextInt(87) + 40);
      String code = getCode();
      while (customFunctionElementsWithCode.values.contains(code))
        code = getCode();
      data.creatorAiData!.functionCode = code;
      customFunctionElementsWithCode[key] = code;
    }
    data.mapKey = key;
    _currentCanvasElements[key] = data;
  }

  void removeCanvasElement(String elementKey) {
    // this._currentCanvasElements[UniqueKey().hashCode.toString()] = data;
    List toBeRemoved = [];
    curveConnections.forEach((element) {
      if (element.firstElementId == elementKey ||
          element.secondElementId == elementKey) toBeRemoved.add(element);
    });
    curveConnections.removeAll(toBeRemoved);
    CreatorElementData? data = currentCanvasElements[elementKey];
    if (data?.categoryType == CreatorCategoryType.Functions) {
      customFunctionElementsWithCode.remove(elementKey);
    }
    currentCanvasElements.remove(elementKey);
  }
}

class CreatorElementConnection extends Equatable {
  final String firstElementId;
  final String secondElementId;
  final int inputKnobIndex;
  final int outputKnobIndex;

  const CreatorElementConnection({
    required this.firstElementId,
    required this.inputKnobIndex,
    required this.secondElementId,
    required this.outputKnobIndex,
  });

  Map toMap() {
    return {
      'firstElementId': this.firstElementId,
      'secondElementId': this.secondElementId,
      'inputKnobIndex': this.inputKnobIndex,
      'outputKnobIndex': this.outputKnobIndex,
    };
  }

  factory CreatorElementConnection.fromMap(Map map) {
    return CreatorElementConnection(
      firstElementId: map['firstElementId'],
      inputKnobIndex: map['inputKnobIndex'],
      secondElementId: map['secondElementId'],
      outputKnobIndex: map['outputKnobIndex'],
    );
  }

  @override
  List<Object?> get props => [
        "${firstElementId}${secondElementId}${inputKnobIndex}${outputKnobIndex}"
      ];
}
