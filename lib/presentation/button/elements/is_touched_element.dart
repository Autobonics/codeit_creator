import 'dart:async';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

class IsTouchedElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const IsTouchedElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<IsTouchedElement> createState() => _IsTouchedElementState();
}

class _IsTouchedElementState extends State<IsTouchedElement> {
  StreamSubscription? subscription;
  // TextToSpeech tts = TextToSpeech();
  // FlutterTts flutterTts = FlutterTts();

  _onMessage(String msg) {
    if (msg[0] != 'p') return;
    if (widget.data?.pin == msg[1]) {
      if (int.parse(msg[2]) == 1) {
        speak();
      }
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    subscription =
        widget.controller?.viewModel.messageStream?.listen(_onMessage);
    if (widget.data != null) {
      widget.data!.update(text: 'Hello', notifyListners: false);
    }
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  // void speak() {
  //   tts.setVolume(_volume);
  //   tts.setRate(_rate);
  //   tts.setPitch(_pitch);
  //   if (widget.data?.text != null) if (widget.data!.text!.isNotEmpty)
  //     tts.speak(widget.data!.text!);
  // }

  void speak() async {
    // tts.setVolume(_volume);
    // tts.setRate(_rate);
    // // tts.setLanguage('en-US');
    // tts.setPitch(_pitch);
    // if (widget.data?.text != null) if (widget.data!.text!.isNotEmpty)
    //   tts.speak(widget.data!.text!);
    if (widget.data?.text == null || widget.data!.text!.isEmpty) return;
    widget.controller?.viewModel.textToSpeech(widget.data!.text!);
    // await flutterTts.setVolume(_volume);
    // await flutterTts.setSpeechRate(_rate);
    // await flutterTts.setPitch(_pitch);
    // flutterTts.speak(widget.data!.text!);
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;
    return Container(
      decoration: BoxDecoration(
        color: widget.data?.color ?? CreatorConsts.creatorButtonColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black38, blurRadius: widget.isPressedDown ? 10 : 20)
        ],
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
                  if (widget.data?.pin != null)
                    Text(
                      '${CreatorConsts.getLocale(context)!.strIf} ${CreatorConsts.getLocale(context)!.pin} ${widget.data?.pin} ${CreatorConsts.getLocale(context)!.isTouched}, ${CreatorConsts.getLocale(context)!.say} :',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  Text(
                    widget.data?.text ?? 'Hello',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
