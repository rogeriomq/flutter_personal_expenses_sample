// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/mixins/platforms_helper.dart';

class AdaptiveTextField extends StatelessWidget with PlatformsHelper {
  final String label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final VoidCallback? onSubmittedAction;

  const AdaptiveTextField({
    Key? key,
    required this.label,
    this.inputType,
    this.onSubmittedAction,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget textField = isApplePlatform()
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              placeholder: label,
              controller: controller,
              keyboardType: inputType,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.purple,
              ),
              focusColor: Colors.purpleAccent,
            ),
            onSubmitted: (_) => onSubmittedAction!(),
          );

    return textField;
  }
}
