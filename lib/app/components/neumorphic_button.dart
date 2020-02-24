import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  final double width;
  final double height;
  final IconData icon;
  final double iconSize;
  final String text;
  final Color color;
  final Function onPressed;

  NeumorphicButton({
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.text,
    this.color = Colors.black87,
    this.onPressed,
  });

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!tapped)
          setState(() { tapped = true; });
        if (widget.onPressed != null)
          widget.onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        onEnd: () {
          setState(() { tapped = false; });
        },
        width: widget.width ?? (widget.text != null ? 150 : 50),
        height: widget.height ?? 50,
        child: _buildChild(),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              offset: tapped ? Offset(1, 1) : Offset(5, 5),
              blurRadius: tapped ? 1 : 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: tapped ? Offset(-1, -1) : Offset(-5, -5),
              blurRadius: tapped ? 1 : 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    if (widget.text != null && widget.icon != null)
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(widget.icon, size: widget.iconSize ?? 25, color: widget.color),
          SizedBox(width: 10),
          Text(widget.text, style: TextStyle(fontSize: 16, color: widget.color)),
        ],
      );
    else if (widget.icon != null)
      return Icon(widget.icon, size: widget.iconSize ?? 25, color: widget.color);

    return Center(child: Text(widget.text, style: TextStyle(fontSize: 25, color: widget.color)));
  }
}
