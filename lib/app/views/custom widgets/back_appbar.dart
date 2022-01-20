import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  @override
  final Size preferredSize;
  const BackAppBar({Key? key, required this.title, required this.actions})
      : preferredSize = const Size.fromHeight(55),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toString(),
        style: Theme.of(context).textTheme.headline3?.copyWith(
            fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ),
      actions: actions,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 13.0,
            backgroundColor: ColorRes.pureWhite,
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: ColorRes.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
