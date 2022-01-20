import 'package:flutter/material.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';

class AvatarChoices extends StatelessWidget {
  final String assetString;

  final Function()? onTap;
  const AvatarChoices(
      {Key? key,
      required this.assetString,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 35.0,
        backgroundColor: ColorRes.pureWhite,
        child: Center(
          child: Image.asset(
            assetString,
            fit: BoxFit.contain,
            height: 45,
            width: 45,
          ),
        ),
      ),
    );
  }
}
