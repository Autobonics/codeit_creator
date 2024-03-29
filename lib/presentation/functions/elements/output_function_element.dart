import 'dart:async';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
// import 'package:text_to_speech/text_to_speech.dart';

class OutputFunctionElement extends StatefulWidget {
  final CreatorElementData? data;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const OutputFunctionElement({
    Key? key,
    this.data,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<OutputFunctionElement> createState() => _OutputFunctionElementState();
}

class _OutputFunctionElementState extends State<OutputFunctionElement> {
  bool isProcessing = false;

  // TextToSpeech tts = TextToSpeech();

  String _onInput(Map? data) {
    if (isProcessing) return 'Still processing from the previous call';
    isProcessing = true;
    setState(() {});
    if (widget.data == null || widget.controller == null) return 'Error';
    String functionCode = widget.data!.creatorAiData!.functionCode!;
    widget.controller?.viewModel.sendMessage('${functionCode}');
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      isProcessing = false;
      setState(() {});
    });
    return 'The function has been called';
  }

  @override
  void initState() {
    if (widget.data?.text == null) {
      widget.data?.update(text: 'Input', notifyListners: false);
    }
    widget.data?.creatorAiData?.function = _onInput;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;
    return GestureDetector(
      onLongPress: () {
        if (widget.controller?.isEditMode.value == true) return;
        _onInput({});
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.data?.color ?? CreatorConsts.creatorFunctionsColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 20)],
        ),
        width: size,
        height: size,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!isProcessing)
                      Text(
                        '${widget.data?.creatorAiData?.gptFunctionData?.name ?? 'Output Function'}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    if (isProcessing) CircularProgressIndicator()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
