import 'package:flutter/material.dart';

class FormFieldHeading extends StatelessWidget {
  final String title;
  const FormFieldHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
