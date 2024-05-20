import 'package:codeit_creator/presentation/move/elements/move_canvas_element.dart';
import 'package:codeit_creator/utilities/converters.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OptionsMenuData {
  Offset position;
  bool hasColorPicker;
  bool hasPortPicker;
  bool hasTextInput;
  bool hasDirectionPicker;
  bool hasButtonPicker;
  bool hasPinPicker;
  int incrementValue;
  bool hasProgrammerSelector;

  OptionsMenuData({
    this.position = const Offset(0, 0),
    this.hasColorPicker = false,
    this.hasPortPicker = false,
    this.hasDirectionPicker = false,
    this.hasTextInput = false,
    this.incrementValue = 5,
    this.hasButtonPicker = false,
    this.hasPinPicker = false,
    this.hasProgrammerSelector = false,
  });

  factory OptionsMenuData.fromMap(Map map) {
    return OptionsMenuData(
      position: Converters.offsetFromString(map['position']) ?? Offset(0, 0),
      hasColorPicker: map['hasColorPicker'],
      hasPortPicker: map['hasPortPicker'],
      hasDirectionPicker: map['hasDirectionPicker'],
      hasTextInput: map['hasTextInput'],
      incrementValue: map['incrementValue'],
      hasButtonPicker: map['hasButtonPicker'],
      hasPinPicker: map['hasPinPicker'],
      hasProgrammerSelector: map['hasProgrammerSelector'],
    );
  }

  Map toMap() {
    return {
      'position': Converters.offsetToString(position),
      'hasColorPicker': hasColorPicker,
      'hasPortPicker': hasPortPicker,
      'hasDirectionPicker': hasDirectionPicker,
      'hasTextInput': hasTextInput,
      'incrementValue': incrementValue,
      'hasButtonPicker': hasButtonPicker,
      'hasPinPicker': hasPinPicker,
      'hasProgrammerSelector': hasProgrammerSelector,
    };
  }
}

enum FunctionProgrammingPlatform { Maker, Programmer }

// ignore: must_be_immutable
class CreatorElementData extends Equatable {
  String? mapKey;
  final String label;
  String? _loopRecieverCode;
  String? _mainFunctionCode;
  String? _interruptRecieverCode;
  // String? _senderFunctionCode;
  Offset _position;
  Color? _color;
  double? _size;
  MoveDirection? _moveDirection;
  int? _port;
  String? _text;
  String? _button;
  String? _pin;
  FunctionProgrammingPlatform? _functionProgrammingPlatform;
  int _inputCount;
  int _outputCount;
  final List<GlobalKey> _inputGlobalKeys;
  final List<GlobalKey> _outputGlobalKeys;
  final Set<String> currentInputDataKeys;
  final Set<String> currentOutputDataKeys;
  final CreatorCategoryType categoryType;

  String? errorMessage = null;
  late OptionsMenuData? optionsMenuData = null;

  ///Arbitrary data specific to widgets
  Map widgetData = {};

  List<VoidCallback> _listners = [];

  ///The code which takes time to execute bust be in [loopRecieverCode].
  ///The code given in this string will only be stopped by the stop
  ///button of codeit.
  String? get loopRecieverCode => _loopRecieverCode;

  ///The code that needs to be in the loop to send data from bbrain
  ///to the codeit.
  String? get mainFunctionCode => _mainFunctionCode;

  ///The code which whici will be called as an interrupt and must be very fast.
  String? get interruptRecieverCode => _interruptRecieverCode;
  // String? get senderFunctionCode => _sendeFunctionCode;
  Offset get position => _position;
  Color? get color => _color;
  double? get size => _size;
  MoveDirection? get moveDirection => _moveDirection;
  int? get port => _port;
  String? get text => _text;
  String? get button => _button;
  String? get pin => _pin;
  List<GlobalKey> get inputGlobalKeys => _inputGlobalKeys;
  List<GlobalKey> get outputGlobalKeys => _outputGlobalKeys;
  FunctionProgrammingPlatform? get functionProgrammingPlatform =>
      _functionProgrammingPlatform;

  CreatorAiData? creatorAiData;

  CreatorElementData({
    required this.label,
    required this.categoryType,
    int inputCount = 1,
    int outputCount = 1,
  })  : _outputCount = outputCount,
        _inputCount = inputCount,
        _position = Offset(0, 0),
        _moveDirection = MoveDirection.Clockwise,
        _inputGlobalKeys = List.generate(inputCount, (index) => GlobalKey()),
        _outputGlobalKeys = List.generate(outputCount, (index) => GlobalKey()),
        currentInputDataKeys = {},
        currentOutputDataKeys = {};

  factory CreatorElementData.fromMap(Map map) {
    CreatorElementData data = CreatorElementData(
      label: map['label'],
      inputCount: map['inputCount'],
      outputCount: map['outputCount'],
      categoryType: Converters.categoryTypeFromString(map['categoryType']),
    );

    data.currentInputDataKeys.addAll(
        (map['currentInputDataIndex'] as List<dynamic>)
            .map((e) => e.toString()));
    data.currentOutputDataKeys.addAll(
        (map['currentOutputDataIndex'] as List<dynamic>)
            .map((e) => e.toString()));

    data.setCode(
      loopRecieverCode: map['loopRecieverCode'],
      mainFunctionCode: map['mainFunctionCode'],
      interruptRecieverCode: map['interruptRecieverCode'],
    );

    data.mapKey = map['mapKey'];

    data.update(
      position: Converters.offsetFromString(map['position']),
      color: Converters.colorFromString(map['color']),
      size: map['size'],
      moveDirection: Converters.directionFromString(map['moveDirection']),
      port: map['port'],
      text: map['text'],
      button: map['button'],
      pin: map['pin'],
      functionProgrammingPlatform: Converters.programmingPlatfromTypeFromString(
          map['functionProgrammingPlatform']),
    );

    data.optionsMenuData = OptionsMenuData.fromMap(map['optionsMenuData']);
    data.widgetData = map['widgetData'];

    Map? creatorAiDataMap = map['creatorAiData'];
    if (creatorAiDataMap != null)
      data.creatorAiData = CreatorAiData.fromMap(creatorAiDataMap);
    return data;
  }

  notifyListeners() {
    this._listners.forEach((element) => element.call());
  }

  void addListener(VoidCallback listener) {
    _listners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listners.remove(listener);
  }

  Map toMap() {
    return {
      'label': this.label,
      'loopRecieverCode': this.loopRecieverCode,
      'mainFunctionCode': this.mainFunctionCode,
      'interruptRecieverCode': this.interruptRecieverCode,
      'position': Converters.offsetToString(this.position),
      'color': Converters.colorToString(this.color),
      'size': this.size,
      'moveDirection': Converters.directionToString(this.moveDirection),
      'port': this.port,
      'text': this.text,
      'button': this.button,
      'pin': this.pin,
      'optionsMenuData': this.optionsMenuData?.toMap(),
      'widgetData': this.widgetData,
      'inputCount': this._inputCount,
      'outputCount': this._outputCount,
      'currentInputDataIndex': this.currentInputDataKeys.toList(),
      'currentOutputDataIndex': this.currentOutputDataKeys.toList(),
      'creatorAiData': this.creatorAiData?.toMap(),
      'categoryType': this.categoryType.name,
      'mapKey': this.mapKey,
      'functionProgrammingPlatform': this.functionProgrammingPlatform?.name,
    };
  }

  void setCode(
      {String? loopRecieverCode,
      String? mainFunctionCode,
      String? interruptRecieverCode}) {
    _loopRecieverCode = loopRecieverCode;
    _mainFunctionCode = mainFunctionCode;
    _interruptRecieverCode = interruptRecieverCode;
  }

  void update({
    Offset? position,
    Color? color,
    double? size,
    MoveDirection? moveDirection,
    int? port,
    String? text,
    String? button,
    String? pin,
    bool notifyListners = true,
    FunctionProgrammingPlatform? functionProgrammingPlatform,
  }) {
    _position = position ?? this._position;
    _color = color ?? this._color;
    _size = size ?? this._size;
    _moveDirection = moveDirection ?? this.moveDirection;
    _port = port ?? this.port;
    _text = text ?? this._text;
    _pin = pin ?? this._pin;
    _button = button ?? this._button;
    _functionProgrammingPlatform =
        functionProgrammingPlatform ?? this._functionProgrammingPlatform;
    if (notifyListners) this.notifyListeners();
  }

  String? checkError() {
    this.errorMessage = null;
    if (optionsMenuData!.hasPortPicker && _port == null) {
      this.errorMessage = "Select Port";
    }
    if (optionsMenuData!.hasButtonPicker && _button == null) {
      this.errorMessage = "Select Button";
    }
    if (optionsMenuData!.hasPinPicker && _pin == null) {
      this.errorMessage = "Select Pin";
    }
    this.notifyListeners();
    return errorMessage;
  }

  @override
  List<Object?> get props => [this.label];

  @override
  bool? get stringify => false;
}
