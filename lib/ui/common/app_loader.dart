import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/dimensions.dart';

enum LagoLoaderTheme { light, dark }

extension _Colors on LagoLoaderTheme {
  // ignore: missing_return
  Color get color {
    switch (this) {
      case LagoLoaderTheme.light:
        return Colors.white;
      case LagoLoaderTheme.dark:
        return AppColors.primary;
    }
  }
}

class AppLoader extends StatelessWidget {
  const AppLoader(
      {Key? key,
      this.theme = LagoLoaderTheme.dark,
      this.strokeWidth = Dimens.border_width_large})
      : super(key: key);

  final LagoLoaderTheme theme;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(theme.color),
        backgroundColor: theme.color.withOpacity(0.2));
  }
}
