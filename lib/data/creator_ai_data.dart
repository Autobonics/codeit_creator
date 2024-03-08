import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class CreatorAiData {
  // dynamic Function(dynamic arg)? inputFunction;
  String Function(Map? arg)? function;
  GptFunctionData? gptFunctionData;
  // FunctionData? inputFunctionData;
  String? functionCode;
  String? bonicPythonCode;
  String? xmlData;

  CreatorAiData({
    this.gptFunctionData,
    this.function,
    this.functionCode,
    this.xmlData,
    this.bonicPythonCode,
  });

  Map toMap() {
    return {
      'creatorFunctionData': gptFunctionData?.toMap(),
      'functionCode': functionCode,
      'xmlData': xmlData,
      'bonicPythonCode': bonicPythonCode,
    };
  }

  factory CreatorAiData.fromMap(Map map) {
    return CreatorAiData(
      gptFunctionData: GptFunctionData.fromMap(map['creatorFunctionData']),
      functionCode: map['functionCode'],
      xmlData: map['xmlData'],
      bonicPythonCode: map['bonicPythonCode'],
    );
  }
}

class GptFunctionData extends FunctionData {
  bool hasParameter;

  GptFunctionData({
    required super.name,
    super.description,
    super.parameters,
    required this.hasParameter,
  });

  static GptFunctionData? fromMap(Map? map) {
    if (map == null) return null;
    return GptFunctionData(
      name: map['name'],
      description: map['description'],
      parameters: map['parameters'],
      hasParameter: map['hasParameter'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ...this.toJson(),
      ...{'hasParameter': hasParameter},
    };
  }
}
