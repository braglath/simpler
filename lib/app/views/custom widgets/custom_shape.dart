import 'package:flutter/material.dart';

import 'package:blur/blur.dart';

class CustomShape extends StatelessWidget {
  const CustomShape(
      {Key? key,
      required this.boxShape,
      required this.shadowColor,
      required this.onTap,
      required this.padding,
      required this.child,
      required this.gradientColor,
      required this.borderRadius,
      required this.borderRadius2})
      : super(key: key);
  final BoxShape boxShape;
  final Color shadowColor;
  final Function()? onTap;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  final Color gradientColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadius? borderRadius2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: borderRadius,
            gradient: LinearGradient(
                colors: [Colors.white, gradientColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  color: shadowColor.withOpacity(0.8),
                  spreadRadius: 0)
            ],
            shape: boxShape),
        child: SizedBox(
          child: Padding(padding: padding, child: child),
        ).frosted(
          borderRadius: borderRadius2,
          blur: 5,
          frostOpacity: 0.1,
        ),
      ),
    );
  }
}
