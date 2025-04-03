import 'package:flutter/material.dart';
import '../../core/utils/dimensions.dart';
import '../../extension/context_extensions.dart';

class KeyboardPadding extends StatelessWidget {
  final double bottomOffset;
  final bool hasToolbar;

  const KeyboardPadding(
      {Key? key, this.bottomOffset = 0.0, this.hasToolbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = context.keyboardPadding(bottomOffset);
    if (hasToolbar) {
      height += Dimens.keyboard_toolbar_height;
    }
    return SizedBox(height: context.isKeyboardVisible ? height : 0);
  }
}
