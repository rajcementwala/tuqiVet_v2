import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../localizations/base_localization.dart';
import '../common/action_button.dart';

class SelectAnimalBottomSheetWidget extends StatefulWidget {

  final Function(List<String>) onSelectionCallBack;

  const SelectAnimalBottomSheetWidget({required this.onSelectionCallBack, super.key});

  @override
  State<StatefulWidget> createState() {
    return SelectAnimalBottomSheetState();
  }
}

class SelectAnimalBottomSheetState extends State<SelectAnimalBottomSheetWidget> {
  List<int> selectedList =[];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration( color: AppColors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(child: Text(BaseLocalization.currentLocalization().chooseAnimalType,style: AppFontTextStyles.textMedium.copyWith(fontSize: 16,color: AppColors.blackTextColor),)),
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(AppSvgImage.icClose))
            ],
          ),
          Text(BaseLocalization.currentLocalization().selectAnimalForBetterResult,style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),
          const SizedBox(height: 24,),

          Expanded(
            child: GridView.count(crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: List.generate(8, (index){
              return InkWell(
                onTap: (){
                  if(selectedList.contains(index)){
                    selectedList.remove(index);
                  }else{
                    selectedList.add(index);
                  }
                  setState(() {

                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12) ),
                            border: Border.all(color: AppColors.darkTextColor,width: selectedList.contains(index)?2:0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill,
                            imageUrl: 'https://picsum.photos/200/300',
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                SvgPicture.asset(AppSvgImage.icLanguage),
                          ),
                        ),
                      ),

                    ),
                    Text('Name Here',style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),

                  ],
                ),

              );
            }),),
          ),
          const SizedBox(height: 16,),
          ActionButton(title: BaseLocalization.currentLocalization().lblContinue,onTap: (){

            widget.onSelectionCallBack([]);


          },)
        ],

      ),

    );
  }
}
