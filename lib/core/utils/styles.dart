// ignore_for_file: avoid_classes_with_only_static_members, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

abstract class FontConstants {
  static const interFamily = 'Inter';
}

abstract class TextStyles {
  static const TextStyle textBold = TextStyle(
    fontFamily: FontConstants.interFamily,
    fontWeight: FontWeight.bold,
    fontSize: Dimens.text_xxlarge,
    color: AppColors.primary,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textNormal = TextStyle(
    fontFamily: FontConstants.interFamily,
    fontWeight: FontWeight.normal,
    fontSize: Dimens.text_normal,
    color: AppColors.primary,
    overflow: TextOverflow.ellipsis,
  );
}
