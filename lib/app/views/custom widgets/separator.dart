import 'package:flutter/material.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  colors: [Colors.white, ColorRes.purpleSecondaryBtnColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            )));
  }
}
