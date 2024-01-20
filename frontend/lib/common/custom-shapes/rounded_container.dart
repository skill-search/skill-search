import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.showBorder = false,
      this.radius = 16,
      this.backgrounColor = const Color(0xFFFFFFFF),
      this.borderColor = const Color(0xFFD9D9D9)});

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgrounColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgrounColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null,
        ),
        child: child);
  }
}
