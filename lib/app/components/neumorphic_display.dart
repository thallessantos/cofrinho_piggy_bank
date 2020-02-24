import 'package:flutter/material.dart';

class NeumorphicDisplay extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  NeumorphicDisplay({
    @required this.child,
    this.width = 100,
    this.height = 100,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  _NeumorphicDisplayState createState() => _NeumorphicDisplayState();
}

class _NeumorphicDisplayState extends State<NeumorphicDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Container(
        padding: widget.padding,
        child: widget.child,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              offset: Offset(-10, -10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(10, 10),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0, 0),
              blurRadius: 15,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[200],
          width: 5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            offset: Offset(1, 1),
            blurRadius: 1,
            spreadRadius: .5,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-1, -1),
            blurRadius: 1,
            spreadRadius: .5,
          ),
        ],
      ),
    );
  }
}
