import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import '../../extension/navigation_extensions.dart';
import '../../extension/string_extensions.dart';
import 'action_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String? title;
  final String? primaryButtonTitle;
  final String? secondaryButtonTitle;
  final Function()? onPrimaryTap;
  final Function()? onSecondaryTap;

  const CustomAlertDialog({
    required this.message,
    this.title,
    this.primaryButtonTitle,
    this.secondaryButtonTitle,
    this.onPrimaryTap,
    this.onSecondaryTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius_normal)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: MAXIMUM_CTA_WIDTH_TABLETS),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space_xlarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: Dimens.space_xxlarge),
              if (title.isNotNullOrBlank)
                Column(
                  children: <Widget>[
                    Text(
                      title!,
                      style: TextStyles.textBold
                          .copyWith(fontSize: Dimens.text_medium),
                    ),
                    const SizedBox(height: Dimens.space_medium),
                  ],
                ),
              if (message.isNotBlank)
                Column(
                  children: <Widget>[
                    Text(
                      message,
                      style: TextStyles.textNormal.copyWith(
                          overflow: TextOverflow.visible,
                          height: Dimens.text_height_xxlarge),
                    ),
                    const SizedBox(height: Dimens.space_large),
                  ],
                ),
              if (primaryButtonTitle.isNotNullOrBlank) ...[
                ActionButton(
                  height: Dimens.button_size_large,
                  titleTextStyle: TextStyles.textNormal,
                  title: primaryButtonTitle!,
                  onTap: () {
                    context.pop();
                    if (onPrimaryTap != null) onPrimaryTap!();
                  },
                ),
                const SizedBox(height: Dimens.space_normal),
              ],
              if (secondaryButtonTitle.isNotNullOrBlank)
                ActionButton(
                  height: Dimens.button_size_large,
                  titleTextStyle: TextStyles.textNormal,
                  title: secondaryButtonTitle!,
                  hasBorder: false,
                  onTap: () {
                    context.pop();
                    if (onSecondaryTap != null) onSecondaryTap!();
                  },
                ),
              const SizedBox(height: Dimens.space_medium),
            ],
          ),
        ),
      ),
    );
  }
}
