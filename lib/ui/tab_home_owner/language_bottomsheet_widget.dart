import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../localizations/base_localization.dart';

class LanguageBottomSheetWidget extends StatelessWidget{

  final String language ='English';
  final Function(String) onSelectionCallBack;
  const LanguageBottomSheetWidget({required this.onSelectionCallBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(child: Text(BaseLocalization.currentLocalization().language,style: AppFontTextStyles.textMedium.copyWith(fontSize: 16,color: AppColors.blackTextColor),)),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppSvgImage.icClose))
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.dividerColor,),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Text(
                        'English',
                        style: AppFontTextStyles.textMedium.copyWith(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.dividerColor,),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Text(
                        'Arabic',
                        style: AppFontTextStyles.textMedium.copyWith(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],

            ),
        ),
      ],
    );
  }

}