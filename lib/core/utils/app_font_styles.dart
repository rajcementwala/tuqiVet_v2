// ignore_for_file: avoid_classes_with_only_static_members, constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'dimensions.dart';

abstract class FontConstants {
  static const funnelFamily = 'FunnelDisplay';
}


abstract class AppFontTextStyles {


  static const TextStyle textNormal = TextStyle(
    fontFamily: FontConstants.funnelFamily,
    fontWeight: FontWeight.normal,
    fontSize: 17.0,
    color: AppColors.white,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textBold = TextStyle(
    fontFamily: FontConstants.funnelFamily,
    fontWeight: FontWeight.bold,
    fontSize: Dimens.text_xxlarge,
    color: AppColors.white,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textMedium = TextStyle(
    fontFamily: FontConstants.funnelFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppColors.white,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textLight = TextStyle(
    fontFamily: FontConstants.funnelFamily,
    fontWeight: FontWeight.w300,
    fontSize: 18,
    color: AppColors.white,
    overflow: TextOverflow.ellipsis,
  );
}


