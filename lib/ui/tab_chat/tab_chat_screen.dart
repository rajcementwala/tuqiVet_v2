import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../blocs/chat_tab_bloc/chat_tab_bloc.dart';
import '../../blocs/chat_tab_bloc/chat_tab_contract.dart';
import '../../core/base_state.dart';
import '../../core/screen_state.dart';
import '../../core/utils/app_font_styles.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';
import '../../core/utils/images.dart';
import '../../core/view_actions.dart';
import '../../localizations/base_localization.dart';

class ChatTabScreen extends StatefulWidget {
  @override
  ChatTabScreenState createState() => ChatTabScreenState();
}

class ChatTabScreenState
    extends BaseState<ChatTabBloc, ChatTabScreen> {
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
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          centerTitle: false,
          
          actions: [ContainerBox(child: SvgPicture.asset(AppSvgImage.icSearch),padding: const EdgeInsets.all(14),borderRadius: 8,),const SizedBox(width: 12,)],
          titleTextStyle: AppFontTextStyles.textNormal
              .copyWith(fontSize: 16, color: AppColors.blackTextColor),
          title: Text(BaseLocalization.currentLocalization().chat),
        ),
        
        body: BlocProvider.value(
          value: bloc,
          child: BlocBuilder<ChatTabBloc, ChatTabData>(
            builder: (context, data) {
              switch (data.state) {
                case ScreenState.empty:
                case ScreenState.loading:
                case ScreenState.content:
                  return _ChatBody(
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

class _ChatBody extends StatelessWidget {
  final ChatTabData data;
  final ChatTabBloc bloc;

  const _ChatBody({required this.data, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:

      ListView.separated(
          padding: EdgeInsets.zero,


          itemBuilder: (context,int index){

            return const _ChatListItem(

            );
          }, separatorBuilder: (context,index){
        return const Divider(height: 1,color: AppColors.dividerColor,);
      }, itemCount: 20),
    );
  }
}


class _ChatListItem extends StatelessWidget{


  const _ChatListItem({ super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: CachedNetworkImageProvider('https://picsum.photos/200/300'),
          ),
          const SizedBox(width: 10,),
          Expanded(


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

            Row(
              spacing: 10,
              children: [
                Expanded(child: Text('Name Here',style: AppFontTextStyles.textMedium.copyWith(fontSize: 16,color: AppColors.blackTextColor),)),
                Text('06:30 PM',style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),


              ],
            ),
            Text('Last message here',style: AppFontTextStyles.textNormal.copyWith(fontSize: 14,color: AppColors.blackTextColor),),

                        ],
                      ),
          ),

        ],
      ),
    );
  }

}
