import 'package:flutter/material.dart';

import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/views/animations/top_to_bottom_animation.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.onProfileTap,
      required this.onLeadingTap})
      : preferredSize = const Size.fromHeight(55),
        super(key: key);

  final Size preferredSize;
  final String title;
  final Function? onProfileTap;
  final Function? onLeadingTap;

  // ModalRoute.of(context)!.settings.name!.contains('/submit-story')

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ToptoBottomAnimation(
        duration: const Duration(milliseconds: 800),
        child: Text(title, style: Theme.of(context).textTheme.caption),
      ),
      centerTitle: false,
      leading: CustomLeadingWidget(onLeadingTap: () => onLeadingTap),
      actions: <Widget>[
        CustomProfileImage(onProfileTap: onProfileTap),
      ],
    );
  }
}

class CustomProfileImage extends StatelessWidget {
  final Function? onProfileTap;
  const CustomProfileImage({Key? key, required this.onProfileTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 15,
          child: Icon(
            Icons.person,
            color: ColorRes.textColor,
          ),
        ));
  }
}

class CustomLeadingWidget extends StatelessWidget {
  final Function()? onLeadingTap;
  const CustomLeadingWidget({Key? key, required this.onLeadingTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLeadingTap,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: ColorRes.pureWhite,
              radius: 15,
              child: CircleAvatar(
                radius: 13.0,
                backgroundColor: ColorRes.pureWhite,
                child: Center(
                  child: Image.asset(
                    AssetIcons.drawer,
                    color: ColorRes.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
