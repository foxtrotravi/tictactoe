import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(4),
    this.alignment = Alignment.center,
    required this.onPressed,
  });

  final Widget child;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;
  final VoidCallback onPressed;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  double height = 50;
  double width = 300;
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        buttonPressed();
        widget.onPressed();
        await Future.delayed(
          const Duration(milliseconds: 150),
        );
        buttonReleased();
      },
      onTapUp: (_) {
        buttonPressed();
      },
      onLongPressUp: () {
        buttonReleased();
      },
      onLongPressDown: (_) {
        buttonPressed();
      },
      onLongPressEnd: (_) {
        buttonReleased();
        widget.onPressed();
      },
      onHorizontalDragEnd: (_) {
        buttonReleased();
        widget.onPressed();
      },
      child: AnimatedContainer(
        padding: widget.padding,
        duration: const Duration(milliseconds: 100),
        color: color,
        height: height,
        width: width,
        alignment: widget.alignment,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }

  void buttonPressed() {
    height = 45;
    width = 280;
    color = Colors.blueAccent;
    setState(() {});
  }

  void buttonReleased() {
    height = 50;
    width = 300;
    color = Colors.blue;
    setState(() {});
  }
}
