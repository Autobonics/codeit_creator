import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_ai_data.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum CurrentState { Listening, Processing, Speaking, Idle }

class GptElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const GptElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<GptElement> createState() => _GptElementState();
}

class _GptElementState extends State<GptElement> {
  StreamSubscription? subscription;
  bool hasProcessed = false;
  SpeechToText _speechToText = SpeechToText();
  String lastWord = '';
  CurrentState currentState = CurrentState.Idle;
  List<Messages> gptMessages = [];

  // TextToSpeech tts = TextToSpeech();
  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  _onMessage(String msg) {
    if (msg[0] != 'b' || hasProcessed) return;
    if (widget.data?.button == msg[1]) {
      if (int.parse(msg[2]) == 1) {
        chatComplete(text: widget.data?.text);
        // _onPress();
        hasProcessed = true;
      }
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    subscription =
        widget.controller?.viewModel.messageStream?.listen(_onMessage);
    widget.controller?.isEditMode.addListener(() {
      if (widget.controller?.isEditMode.value == true) _stopSpeaking();
    });
    if (widget.data?.text == null) {
      widget.data?.update(text: 'Prompt', notifyListners: false);
    }
    _initSpeech();
    super.initState();
  }

  updateState(CurrentState state) {
    currentState = state;
    if (mounted) setState(() {});
  }

  void _startListening() async {
    updateState(CurrentState.Listening);
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 8),
      partialResults: true,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWord = result.recognizedWords;
    widget.data?.update(text: lastWord, notifyListners: true);
    // _onPress(text: result.recognizedWords);
    // setState(() {
    //   _lastWords = result.recognizedWords;
    // });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  speak(String? text) async {
    updateState(CurrentState.Speaking);
    await widget.controller?.viewModel
        .textToSpeech(text ?? "I didn't get any response");
    updateState(CurrentState.Idle);
  }

  _stopSpeaking() async {
    await widget.controller?.viewModel.stopTextToSpeech();
    updateState(CurrentState.Idle);
  }

  chatComplete({String? text}) async {
    updateState(CurrentState.Processing);
    List<CreatorAiData> datas = [];
    setState(() {});
    widget.data?.currentInputDataKeys.forEach((element) {
      CreatorAiData? data = widget.controller?.creatorData
          .currentCanvasElements[element]?.creatorAiData;
      if (data != null) datas.add(data);
    });

    widget.data?.currentOutputDataKeys.forEach((element) {
      CreatorAiData? data = widget.controller?.creatorData
          .currentCanvasElements[element]?.creatorAiData;
      if (data != null) datas.add(data);
    });

    String? response = await widget.controller?.viewModel.chatComplete(
      text: text ?? widget.data?.text ?? 'How are you?',
      datas: datas,
      messages: gptMessages,
    );
    updateState(CurrentState.Idle);
    speak(response);
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;
    return GestureDetector(
      onLongPressStart: widget.controller?.isEditMode.value == false
          ? (detils) async {
              await _stopSpeaking();
              _startListening();
            }
          : null,
      onLongPressEnd: widget.controller?.isEditMode.value == false
          ? (details) {
              _speechToText.cancel();
              updateState(CurrentState.Idle);
              chatComplete(text: lastWord);
            }
          : null,
      onTap: widget.controller?.isEditMode.value == false
          ? () {
              chatComplete(text: lastWord);
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: widget.data?.color ?? CreatorConsts.plutoColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: widget.isPressedDown ? 7 : 15,
            )
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
                    if (currentState == CurrentState.Idle)
                      Container(
                        height: size * 0.5,
                        width: size * 0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bonic.png'),
                          ),
                        ),
                      ),
                    if (currentState == CurrentState.Processing)
                      BreathingIcon(
                        size: size,
                        child: Container(
                          height: size * 0.3,
                          width: size * 0.3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/bonic.png'),
                            ),
                          ),
                        ),
                      ),
                    if (currentState == CurrentState.Listening)
                      BreathingIcon(
                        size: size,
                        icon: Icons.mic,
                      ),
                    if (currentState == CurrentState.Speaking)
                      BreathingIcon(
                        size: size,
                        icon: Icons.volume_up_rounded,
                      ),
                    const Text(
                      'Bonic AI',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    if (widget.data?.text != null)
                      Text(
                        widget.data!.text!,
                        style: const TextStyle(
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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

class BreathingIcon extends StatefulWidget {
  final double? size;
  final IconData? icon;
  final Widget? child;
  const BreathingIcon({
    super.key,
    this.size,
    this.icon,
    this.child,
  });

  @override
  State<BreathingIcon> createState() => _BreathingIconState();
}

class _BreathingIconState extends State<BreathingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.scale(
        scale: 1 + (0.5 * controller.value),
        child: child,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8,
        ),
        child: widget.child ??
            Icon(
              widget.icon,
              size: widget.size! * 0.25,
              color: Colors.white,
            ),
      ),
    );
  }
}
