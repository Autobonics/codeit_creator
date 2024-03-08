import 'dart:async';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
// import 'package:text_to_speech/text_to_speech.dart';

class ScrollElement extends StatefulWidget {
  final CreatorElementData? data;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const ScrollElement({
    Key? key,
    this.data,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<ScrollElement> createState() => _ScrollElementState();
}

class _ScrollElementState extends State<ScrollElement> {
  bool isProcessing = false;

  // TextToSpeech tts = TextToSpeech();

  String _onInput(Map? data) {
    if (data == null) return 'The input parameter is invalid';
    if (isProcessing) return 'Still processing from the previous call';
    isProcessing = true;
    setState(() {});
    String sdata = data['result'];
    if (sdata.length > 9) sdata = sdata.substring(0, 9);
    widget.controller?.viewModel.sendMessage('%$sdata');
    widget.data?.update(text: sdata, notifyListners: false);
    Future.delayed(Duration(milliseconds: sdata.length * 1000)).then((value) {
      isProcessing = false;

      setState(() {});
    });
    return 'The data has been sent to the display';
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
        _onInput({'result': widget.data?.text});
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.data?.color ?? CreatorConsts.creatorDisplayColor,
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
                        'Scroll: ${widget.data?.text ?? 'Input'}',
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
