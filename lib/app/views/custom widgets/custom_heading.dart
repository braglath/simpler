import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      heading,
      style: Theme.of(context)
          .textTheme
          .headline3
          ?.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
    );
  }
}
