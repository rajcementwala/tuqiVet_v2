// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import 'colors.dart';

class AppDecoration{
  static Decoration getBoxDecoration({double? radius, Color? color, Color? shadowColor}){
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(color: AppColors.dividerColor, width: 1),
        boxShadow: [
          BoxShadow(
              color: shadowColor ?? Colors.black.withOpacity(0.07),
              blurStyle: BlurStyle.outer,
              blurRadius: 10,
              spreadRadius: -1,
          ),
        ],
        color: color,
    );
  }
}