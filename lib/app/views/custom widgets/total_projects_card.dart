import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';

class TotalProjects extends StatelessWidget {
  final String title;
  final String number;
  final String iconAsset;
  final bool newChild;
  final Widget child;
  const TotalProjects(
      {Key? key,
      required this.title,
      required this.number,
      required this.iconAsset,
      required this.newChild,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShape(
        borderRadius: BorderRadius.circular(30),
        borderRadius2: BorderRadius.circular(30),
        boxShape: BoxShape.rectangle,
        shadowColor: ColorRes.pinkMainBtnColor,
        onTap: () => print('total projects'),
        padding: const EdgeInsets.all(15),
        child: newChild
            ? child
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    iconAsset,
                    width: 65,
                    height: 65,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    title,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(width: 5),
                  AutoSizeText(
                    number,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
        gradientColor: ColorRes.pinkMainBtnColor);
  }
}
