import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/images.dart';

class AppNetworkImage extends StatefulWidget{
  final double? height;
  final double? width;
  final String url;
  final BoxFit? fit;



  const AppNetworkImage({required this.url, super.key, this.height, this.width, this.fit});
  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
@override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: widget.height??120,
      width: widget.width??120,
      fit:widget.fit?? BoxFit.fill,
      imageUrl: widget.url,
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>

          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                  value: downloadProgress.progress),
            ),
          ),
      errorWidget: (context, url, error) =>
          SvgPicture.asset(AppSvgImage.icImagePLaceHolder),
    );
  }}