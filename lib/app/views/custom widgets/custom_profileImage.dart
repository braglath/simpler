import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';

class CustomProfileImage extends StatelessWidget {
  final Function()? onProfileTap;
  final bool needAvatar;
  final String asset;
  final double circleRadius;
  final double imageHeight;
  final double imageWidth;
  final bool needSearchIcon;
  const CustomProfileImage(
      {Key? key,
      required this.onProfileTap,
      required this.needAvatar,
      required this.asset,
      required this.circleRadius,
      required this.imageHeight,
      required this.imageWidth,
      required this.needSearchIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: circleRadius,
          child: needSearchIcon
              ? const FaIcon(
                  FontAwesomeIcons.search,
                  color: ColorRes.textColor,
                  size: 18,
                )
              : Image.asset(
                  needAvatar ? UserDataDetails().readUserAvatar() : asset,
                  fit: BoxFit.contain,
                  height: imageHeight,
                  width: imageWidth,
                )),
    );
  }
}
