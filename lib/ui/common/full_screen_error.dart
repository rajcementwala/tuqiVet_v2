import 'package:flutter/material.dart';
import '../../localizations/base_localization.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';
import 'action_button.dart';

class FullScreenError extends StatelessWidget {
  final String title;
  final String message;
  final Function onRetryTap;

  const FullScreenError(
      {required this.onRetryTap, this.message = '', this.title = '', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: Dimens.navigation_bar_height,
            ),
            Text(
              title,
              style: TextStyles.textBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.space_medium),
            Text(message,
                maxLines: 5,
                style: TextStyles.textNormal.copyWith(
                    overflow: TextOverflow.visible,
                    height: Dimens.text_height_xxlarge)),
            const SizedBox(height: Dimens.space_large),
            ActionButton(
              title:
                  BaseLocalization.currentLocalization().noInternetConnection,
              onTap: onRetryTap as void Function()?,
            ),
          ],
        ),
      ),
    );
  }
}
