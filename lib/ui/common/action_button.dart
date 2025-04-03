import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final String? image;
  final TextStyle titleTextStyle;
  final Function? onTap;
  final bool isLoading;
  final Color? disabledColor;
  final bool hasBorder;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final bool isEnabled;
  final double height;
  final double width;
  final double imageWidth;
  final double imageHeight;
  final Color? backGroundColor;

  const ActionButton({
    required this.title,
    this.image,
    this.backGroundColor,
    this.titleTextStyle = TextStyles.textNormal,
    this.onTap,
    this.isLoading = false,
    this.disabledColor = AppColors.disableColor,
    this.hasBorder = false,
    this.borderColor = AppColors.primary,
    this.borderWidth = Dimens.border_width_small,
    this.borderRadius = Dimens.radius_xxxlarge,
    this.isEnabled = true,
    this.height = Dimens.button_size_xlarge,
    this.width = double.infinity,
    this.imageHeight = Dimens.icon_size_xsmall,
    this.imageWidth = Dimens.icon_size_xsmall,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor,
              width: borderWidth,
              style: hasBorder ? BorderStyle.solid : BorderStyle.none),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: isEnabled && !isLoading
            ? backGroundColor ?? AppColors.buttonBackground
            : disabledColor,
        textStyle: titleTextStyle.copyWith(color: AppColors.buttonText),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: MAXIMUM_CTA_WIDTH_TABLETS),
        height: height,
        width: width,
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: Dimens.icon_size_normal,
                  height: Dimens.icon_size_normal,
                  child: CircularProgressIndicator(
                    strokeWidth: Dimens.border_width_large,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.black.withOpacity(0.2),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (image != null) ...[
                      Container(
                        width: imageWidth,
                        height: imageHeight,
                        child: SvgPicture.asset(
                          image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.space_normal,
                      ),
                    ],
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(title,
                          style: titleTextStyle.apply(
                              color: AppColors.buttonText)),
                    ),
                  ],
                ),
        ),
      ),
      onPressed: isEnabled && onTap != null && !isLoading
          ? onTap as void Function()?
          : () {},
    );
  }
}
