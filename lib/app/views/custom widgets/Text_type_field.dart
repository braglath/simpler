import 'package:flutter/material.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class TextTypeField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxlines;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  const TextTypeField(
      {Key? key,
      required this.controller,
      required this.maxlines,
      required this.validator,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: () => FocusScope.of(context).dispose(),
      controller: controller,
      maxLines: maxlines,
      style: Theme.of(context).textTheme.headline4,
      cursorColor: ColorRes.textColor,
      keyboardType: textInputType,
      validator: validator,
    );
  }
}
