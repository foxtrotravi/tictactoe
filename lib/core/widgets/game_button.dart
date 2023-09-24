import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  const GameButton({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(4),
    this.alignment = Alignment.center,
    required this.onPressed,
    this.color = Colors.blue,
  });

  final Widget child;
  final EdgeInsets padding;
  final AlignmentGeometry alignment;
  final VoidCallback onPressed;
  final Color color;

  @override
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  double height = 50;
  double width = 300;

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
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        height: height,
        width: width,
        alignment: widget.alignment,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }

  void buttonPressed() {
    height = 45;
    width = 280;
    setState(() {});
  }

  void buttonReleased() {
    height = 50;
    width = 300;
    setState(() {});
  }
}
