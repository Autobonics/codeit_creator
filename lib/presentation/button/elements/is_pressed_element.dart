import 'dart:async';
import 'package:codeit_creator/utilities/creator_constants.dart';
import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
// import 'package:text_to_speech/text_to_speech.dart';

class IsPressedElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorControllerBase? controller;

  const IsPressedElement({
    super.key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  });

  @override
  State<IsPressedElement> createState() => _IsPressedElementState();
}

class _IsPressedElementState extends State<IsPressedElement> {
  StreamSubscription? subscription;
  bool isSpeaking = false;

  // TextToSpeech tts = TextToSpeech();

  _onMessage(String msg) {
    if (msg[0] != 'b') return;
    if (widget.data?.button == msg[1]) {
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
    if (widget.data?.text == null) {
      widget.data?.update(text: 'Hello', notifyListners: false);
    }
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  void speak() async {
    // tts.setVolume(_volume);
    // tts.setRate(_rate);
    // // tts.setLanguage('en-US');
    // tts.setPitch(_pitch);
    // if (widget.data?.text != null) if (widget.data!.text!.isNotEmpty)
    //   tts.speak(widget.data!.text!);
    if (widget.data?.text == null || widget.data!.text!.isEmpty) return;
    widget.controller?.viewModel.textToSpeech(widget.data!.text!);
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
                  if (widget.data?.button != null)
                    Text(
                      '${CreatorConsts.getLocale(context)!.strIf} ${CreatorConsts.getLocale(context)!.button} ${widget.data?.button} ${CreatorConsts.getLocale(context)!.isPressed}, ${CreatorConsts.getLocale(context)!.say} :',
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

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final String defaultLanguage = 'en-US';

//   TextToSpeech tts = TextToSpeech();

//   String text = '';
//   double volume = 1; // Range: 0-1
//   double rate = 1.0; // Range: 0-2
//   double pitch = 1.0; // Range: 0-2

//   String? language;
//   String? languageCode;
//   List<String> languages = <String>[];
//   List<String> languageCodes = <String>[];
//   String? voice;

//   TextEditingController textEditingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     textEditingController.text = text;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initLanguages();
//     });
//   }

//   Future<void> initLanguages() async {
//     /// populate lang code (i.e. en-US)
//     languageCodes = await tts.getLanguages();

//     /// populate displayed language (i.e. English)
//     final List<String>? displayLanguages = await tts.getDisplayLanguages();
//     if (displayLanguages == null) {
//       return;
//     }

//     languages.clear();
//     for (final dynamic lang in displayLanguages) {
//       languages.add(lang as String);
//     }

//     final String? defaultLangCode = await tts.getDefaultLanguage();
//     if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
//       languageCode = defaultLangCode;
//     } else {
//       languageCode = defaultLanguage;
//     }
//     language = await tts.getDisplayLanguageByCode(languageCode!);

//     /// get voice
//     voice = await getVoiceByLang(languageCode!);

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<String?> getVoiceByLang(String lang) async {
//     final List<String>? voices = await tts.getVoiceByLang(languageCode!);
//     if (voices != null && voices.isNotEmpty) {
//       return voices.first;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Text-to-Speech Example'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     controller: textEditingController,
//                     maxLines: 5,
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Enter some text here...'),
//                     onChanged: (String newText) {
//                       setState(() {
//                         text = newText;
//                       });
//                     },
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Volume'),
//                       Expanded(
//                         child: Slider(
//                           value: volume,
//                           min: 0,
//                           max: 1,
//                           label: volume.round().toString(),
//                           onChanged: (double value) {
//                             initLanguages();
//                             setState(() {
//                               volume = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${volume.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Rate'),
//                       Expanded(
//                         child: Slider(
//                           value: rate,
//                           min: 0,
//                           max: 2,
//                           label: rate.round().toString(),
//                           onChanged: (double value) {
//                             setState(() {
//                               rate = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${rate.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Pitch'),
//                       Expanded(
//                         child: Slider(
//                           value: pitch,
//                           min: 0,
//                           max: 2,
//                           label: pitch.round().toString(),
//                           onChanged: (double value) {
//                             setState(() {
//                               pitch = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${pitch.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Language'),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       DropdownButton<String>(
//                         value: language,
//                         icon: const Icon(Icons.arrow_downward),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         underline: Container(
//                           height: 2,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) async {
//                           languageCode =
//                               await tts.getLanguageCodeByName(newValue!);
//                           voice = await getVoiceByLang(languageCode!);
//                           setState(() {
//                             language = newValue;
//                           });
//                         },
//                         items: languages
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Voice'),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Text(voice ?? '-'),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: ElevatedButton(
//                             child: const Text('Stop'),
//                             onPressed: () {
//                               tts.stop();
//                             },
//                           ),
//                         ),
//                       ),
//                       if (supportPause)
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: ElevatedButton(
//                               child: const Text('Pause'),
//                               onPressed: () {
//                                 tts.pause();
//                               },
//                             ),
//                           ),
//                         ),
//                       if (supportResume)
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: ElevatedButton(
//                               child: const Text('Resume'),
//                               onPressed: () {
//                                 tts.resume();
//                               },
//                             ),
//                           ),
//                         ),
//                       Expanded(
//                           child: Container(
//                         child: ElevatedButton(
//                           child: const Text('Speak'),
//                           onPressed: () {
//                             speak();
//                           },
//                         ),
//                       ))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   bool get supportPause => defaultTargetPlatform != TargetPlatform.android;

//   bool get supportResume => defaultTargetPlatform != TargetPlatform.android;

//   void speak() {
//     tts.setVolume(volume);
//     tts.setRate(rate);
//     if (languageCode != null) {
//       tts.setLanguage(languageCode!);
//     }
//     tts.setPitch(pitch);
//     tts.speak(text);
//   }
// }
