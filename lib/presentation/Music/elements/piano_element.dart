import 'package:codeit_creator/data/creator_controller.dart';
import 'package:codeit_creator/data/creator_element_data.dart';
import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class PianoElement extends StatefulWidget {
  final CreatorElementData? data;
  final bool isPressedDown;
  final double defaultSize;
  final CreatorController? controller;

  const PianoElement({
    Key? key,
    this.data,
    this.isPressedDown = false,
    this.defaultSize = 100,
    this.controller,
  }) : super(key: key);

  @override
  State<PianoElement> createState() => _PianoElementState();
}

class _PianoElementState extends State<PianoElement> {
  Clef currentSelected = Clef.Treble;

  _listner() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    widget.data?.addListener(_listner);
    super.initState();
  }

  @override
  void dispose() {
    widget.data?.removeListener(_listner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.data?.size ?? widget.defaultSize;

    _getClefRow() {
      return Row(
        children: [
          ClEFCard(
            label: "Treble",
            isSelected: currentSelected == Clef.Treble,
            onPressed: () {
              currentSelected = Clef.Treble;
              setState(() {});
            },
            color: widget.data?.color ?? Colors.grey,
            size: size,
          ),
          SizedBox(width: 10),
          ClEFCard(
            label: "Alto",
            isSelected: currentSelected == Clef.Alto,
            onPressed: () {
              currentSelected = Clef.Alto;
              setState(() {});
            },
            color: widget.data?.color ?? Colors.grey,
            size: size,
          ),
          SizedBox(width: 10),
          ClEFCard(
            label: "Bass",
            isSelected: currentSelected == Clef.Bass,
            onPressed: () {
              currentSelected = Clef.Bass;
              setState(() {});
            },
            color: widget.data?.color ?? Colors.grey,
            size: size,
          )
        ],
      );
    }

    _getPiano() {
      return SizedBox(
        height: size,
        width: (16 / 9) * size,
        child: InteractivePiano(
          hideScrollbar: true,
          highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
          naturalColor: widget.data?.color ?? Colors.white,
          accidentalColor: Colors.black,
          noteRange: NoteRange.forClefs([currentSelected]),
          // keyWidth: size * 0.1,
          onNotePositionTapped: widget.controller?.isEditMode.value == false
              ? (NotePosition notePosition) {
                  widget.controller?.viewModel.sendMessage(
                      "'${notePosition.name.replaceAll('♯', '#')}");
                }
              : null,
        ),
      );
    }

    // return Container();

    // return SizedBox(
    //   height: size,
    //   width: (16 / 9) * size,
    //   child: VirtualPiano(
    //     noteRange: const RangeValues(21, 108),
    //     highlightedNoteSets: const [
    //       HighlightedNoteSet({44, 55, 77, 32}, Colors.green),
    //     ],
    //     onNotePressed: (note, pos) {
    //       // Play note
    //     },
    //   ),
    // );

    // return _getPiano();

    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            if (widget.controller != null) _getClefRow(),
            if (widget.controller != null) SizedBox(height: 10),
            _getPiano(),
          ],
        ),
      ),
    );
  }
}

class ClEFCard extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color color;
  final double size;
  final bool isSelected;
  const ClEFCard({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.size,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(isSelected ? 10 : 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.2),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
