import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeumorphicCoinButton extends StatefulWidget {
  final double size;
  final String imageName;
  final Function onPressed;
  final Function onLongPressed;

  NeumorphicCoinButton({
    this.size,
    @required this.imageName,
    this.onPressed,
    this.onLongPressed,
  });

  @override
  _NeumorphicCoinButtonState createState() => _NeumorphicCoinButtonState();
}

class _NeumorphicCoinButtonState extends State<NeumorphicCoinButton> {
  bool tapped = false;
  bool onLongTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() { onLongTapped = true; });
        if (widget.onLongPressed != null)
          widget.onLongPressed();
      },
      onLongPressEnd: (_) {
        setState(() { onLongTapped = false; });
      },
      onTap: () {
        if (!tapped)
          setState(() { tapped = true; });
        if (widget.onPressed != null)
          widget.onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        onEnd: () {
          setState(() { if (!onLongTapped) tapped = false; });
        },
        width: widget.size ?? 70,
        height: widget.size ?? 70,
        child: Image.asset("assets/images/${widget.imageName}"),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              offset: tapped || onLongTapped ? Offset(1, 1) : Offset(5, 5),
              blurRadius: tapped || onLongTapped ? 1 : 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: tapped || onLongTapped ? Offset(-1, -1) : Offset(-5, -5),
              blurRadius: tapped || onLongTapped ? 1 : 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
