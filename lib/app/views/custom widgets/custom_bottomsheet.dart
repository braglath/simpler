import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class CustomBottomSheet {
  BuildContext context;
  IconData icon1;
  IconData icon2;
  IconData? icon3;
  IconData? icon4;
  String title1;
  String titile2;
  String? titile3;
  String? titile4;
  Function()? onTap1;
  Function()? onTap2;
  Function()? onTap3;
  Function()? onTap4;
  bool need3rdTile;
  bool need4thTile;

  CustomBottomSheet(
      {required this.context,
      required this.icon1,
      required this.icon2,
      required this.icon3,
      required this.icon4,
      required this.title1,
      required this.titile2,
      required this.titile3,
      required this.titile4,
      required this.onTap1,
      required this.onTap2,
      required this.onTap3,
      required this.onTap4,
      required this.need3rdTile,
      required this.need4thTile});
  void show() {
    Get.bottomSheet(
      SizedBox(
        child: Wrap(
          children: [
            ListTile(
              tileColor: ColorRes.pureWhite,
              leading: FaIcon(
                icon1,
                color: ColorRes.textColor,
              ),
              title: Text(
                title1,
                style: const TextStyle(
                    color: ColorRes.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: onTap1,
            ),
            _divider(),
            ListTile(
              tileColor: ColorRes.pureWhite,
              leading: FaIcon(
                icon2,
                color: ColorRes.textColor,
              ),
              title: Text(titile2,
                  style: const TextStyle(
                      color: ColorRes.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              onTap: onTap2,
            ),
            need3rdTile ? _divider() : const SizedBox.shrink(),
            need3rdTile
                ? ListTile(
                    tileColor: ColorRes.pureWhite,
                    leading: FaIcon(
                      icon4,
                      color: ColorRes.textColor,
                    ),
                    title: Text(titile4!,
                        style: const TextStyle(
                            color: ColorRes.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    onTap: onTap4,
                  )
                : const SizedBox.shrink(),
            need3rdTile ? _divider() : const SizedBox.shrink(),
            need4thTile
                ? ListTile(
                    tileColor: ColorRes.pureWhite,
                    leading: FaIcon(
                      icon3,
                      color: ColorRes.textColor,
                    ),
                    title: Text(titile3!,
                        style: const TextStyle(
                            color: ColorRes.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    onTap: onTap3,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      // barrierColor: Colors.red[50],
      isDismissible: true,
      enableDrag: true,
    );
  }

  Container _divider() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 1,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.5),
          gradient: const LinearGradient(
              colors: [Colors.white, ColorRes.purpleSecondaryBtnColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ));
  }
}
