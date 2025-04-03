import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../blocs/profile_tab_bloc/profile_tab_bloc.dart';
import '../../blocs/profile_tab_bloc/profile_tab_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/enum.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../localizations/base_localization.dart';

class ProfileTabScreen extends StatefulWidget {
  @override
  ProfileTabScreenState createState() => ProfileTabScreenState();
}

class ProfileTabScreenState
    extends BaseState<ProfileTabBloc, ProfileTabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onViewEvent(ViewAction event) {
    super.onViewEvent(event);

    if (event is NavigateScreen) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          titleTextStyle: AppFontTextStyles.textNormal
              .copyWith(fontSize: 16, color: AppColors.blackTextColor),
          title: Text(BaseLocalization.currentLocalization().profile),
        ),
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ProfileTabBloc, ProfileTabData>(
            builder: (context, data) {
              switch (data.state) {
                case ScreenState.empty:
                case ScreenState.loading:
                case ScreenState.content:
                  return _ProfileBody(
                    bloc: bloc,
                    data: data,
                  );
                default:
                  return Container();
              }
            },
          ),
        ));
  }
}

class _ProfileBody extends StatelessWidget {
  final ProfileTabData data;
  final ProfileTabBloc bloc;

  const _ProfileBody({required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.scaffoldBackgroundColor,

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 24),

          Row(
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3), // Border radius
                  child: ClipOval(child: CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.fill,
                    imageUrl: 'https://picsum.photos/200/300',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        SvgPicture.asset(AppSvgImage.icLanguage),
                  )),
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Doe',style: AppFontTextStyles.textMedium.copyWith(fontSize: 16,color: AppColors.blackTextColor),),
                  Text('+91 0000000000',style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                    decoration: BoxDecoration(border: Border.all(width: 1,color: AppColors.buttonBackground),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text( BaseLocalization
                        .currentLocalization()
                        .edit,
                      style: AppFontTextStyles.textNormal
                          .copyWith(fontSize: 16, color: AppColors.darkTextColor),),
                  )
                ],

              ),
              
              

            ]
          ),
          const SizedBox(height: 26),
          ContainerBox(
          borderRadius  :12,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),

                itemBuilder: (context,int index){

                  return _ProfileListItem(item: OwnerProfileOptions.values[index],

                  );
                }, separatorBuilder: (context,index){
              return const Divider(height: 1,color: AppColors.dividerColor,);
            }, itemCount: OwnerProfileOptions.values.length),

          )
        ],


      ),
    );
  }
}


class _ProfileListItem extends StatelessWidget{

 final OwnerProfileOptions item;
  const _ProfileListItem({required this.item, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(

        children: [
          SvgPicture.asset(item.getIcon),
          const SizedBox(width: 10,),
          Expanded(child: Text(item.getStringValue,style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),)),
          SvgPicture.asset(AppSvgImage.icArrowRightGray),

        ],
      ),
    );
  }

}
