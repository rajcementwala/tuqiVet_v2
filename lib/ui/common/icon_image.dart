import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/colors.dart';

class IconImage extends StatefulWidget{
  final BoxShape? shape;
  final double? height;
  final double? width;
  final String image;
  final Color? color;
  final EdgeInsets? edgeInsets;

   IconImage({required this.image, super.key, this.shape, this.height, this.width,  this.color, this.edgeInsets});

  @override
  State<IconImage> createState() => _IconImageState();
}

class _IconImageState extends State<IconImage> {
  @override
  Widget build(BuildContext context) {
    return Container(height: widget.height??24,
    padding: widget.edgeInsets??const EdgeInsets.all(8),
    width: widget.width??24,
    decoration: BoxDecoration(
      shape:widget.shape??BoxShape.circle,
      color:widget.color??AppColors.white
    ),
      child: SvgPicture.asset(widget.image),
    );
  }
}