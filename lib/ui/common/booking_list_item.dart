import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';

class BookingListItem extends StatelessWidget {
  final Function(int) callback;

  const BookingListItem({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){

          callback.call(0);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 110,
                width: 110,
                fit: BoxFit.fill,
                imageUrl: 'https://picsum.photos/200/300',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    SvgPicture.asset(AppSvgImage.icLanguage),
              ),
              Expanded(

                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Flexible(
                              child: Text(
                                'Doctor Name ausg',
                                style: AppFontTextStyles.textMedium.copyWith(
                                    fontSize: 18, color: AppColors
                                    .blackTextColor),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.buttonBackground.withAlpha(
                                      30)), child: Text(
                              'Visit',
                              style: AppFontTextStyles.textMedium.copyWith(
                                  fontSize: 12, color: AppColors.darkTextColor),
                            ),
                            ),

                          ],
                        ),

                        Row(
                          spacing: 3,
                          children: [
                            Text(
                              'Designation',
                              style: AppFontTextStyles.textNormal.copyWith(
                                  fontSize: 14, color: AppColors
                                  .blackTextColor),
                            ),
                            Container(height: 12,
                              width: 1,
                              color: AppColors.blackTextColor,),
                            Text(
                              'Location',
                              style: AppFontTextStyles.textNormal.copyWith(
                                  fontSize: 14, color: AppColors
                                  .blackTextColor),
                            ),
                          ],),
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 3,
                          children: [
                            Expanded(

                              child: Text(
                                'Pending',
                                textAlign: TextAlign.start,
                                style: AppFontTextStyles.textNormal.copyWith(
                                    fontSize: 14, color: AppColors.orange),
                              ),
                            ),


                            SvgPicture.asset(AppSvgImage.icCalender),
                            const SizedBox(width: 3,),
                            Text(
                              '5 days to go',
                              style: AppFontTextStyles.textNormal.copyWith(
                                  fontSize: 14, color: AppColors.darkTextColor),
                            ),
                            const SizedBox(width: 3,),
                            SvgPicture.asset(
                              AppSvgImage.icWhiteArrow, colorFilter:
                            const ColorFilter.mode(
                                AppColors.darkTextColor,
                                BlendMode.srcIn)

                              ,),

                          ],)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
  }
}