import 'package:flutter/material.dart';
import 'package:simpler/app/data/user_data/user_data.dart';

class CustomProfileImage extends StatelessWidget {
  final Function()? onProfileTap;
  final bool needAvatar;
  final String asset;
  final double circleRadius;
  final double imageHeight;
  final double imageWidth;
  const CustomProfileImage(
      {Key? key,
      required this.onProfileTap,
      required this.needAvatar,
      required this.asset,
      required this.circleRadius,
      required this.imageHeight,
      required this.imageWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: circleRadius,
          child: Image.asset(
            needAvatar ? UserDataDetails().readUserAvatar() :  asset ,
            fit: BoxFit.contain,
            height: imageHeight,
            width: imageWidth,
          )),
    );
  }
}
