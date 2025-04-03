import 'package:flutter/cupertino.dart';

import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/enum.dart';
import '../../localizations/base_localization.dart';
import '../common/booking_list_item.dart';

class OwnerBookingTabView extends StatelessWidget{
  final Function(int) callback;

  const OwnerBookingTabView({required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(

      padding: const EdgeInsets.all(16),
      color: AppColors.scaffoldBackgroundColor,

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Wrap(
            runSpacing: 6,
            direction: Axis.horizontal,
            spacing: 6,
            verticalDirection: VerticalDirection.down,
            children: List.generate(ServiceType.values.length, (index) {
              return _AddressWidget(
                 serviceType: ServiceType.values[index],);
            }),
          ),
          Text(
            BaseLocalization.currentLocalization().upcomingBookings,
            style: AppFontTextStyles.textMedium.copyWith(
                fontSize: 20, color: AppColors.blackTextColor),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BookingListItem(callback: (v){
                  callback.call(0);
                },);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              }, itemCount: 3),
          const SizedBox(
            height: 16,
          ),
          Text(
            BaseLocalization.currentLocalization().pastBookings,
            style: AppFontTextStyles.textMedium.copyWith(
                fontSize: 20, color: AppColors.blackTextColor),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return BookingListItem(callback: (v){

                },);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: 3),

        ],
      ),
    );
  }

}
class _AddressWidget extends StatelessWidget {
  final ServiceType serviceType;

  const _AddressWidget(
      {super.key,
        required this.serviceType,
       });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width:serviceType == ServiceType.all ? 2 : 0,
              color: serviceType == ServiceType.all
                  ? AppColors.darkTextColor
                  : AppColors.white)),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            serviceType.stringFromEnum,
            style: AppFontTextStyles.textNormal.copyWith(
                fontSize: 14,
                color: serviceType == ServiceType.all
                    ? AppColors.darkTextColor
                    : AppColors.blackTextColor),
          ),
        ],
      ),
    );
  }
}
