import 'package:flutter/material.dart';
import '../../core/utils/colors.dart';

class ContainerBox extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool? shadowRequired;
  const ContainerBox({
    this.child,
    this.height,
    this.width,
    this.borderRadius,
    this.alignment,
    this.padding,
    this.margin,
    this.color,
    this.borderColor,
    this.gradient,
    this.onTap,
    this.shadowRequired,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: alignment,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
          gradient: gradient,
          border: borderColor != null
              ? Border.all(color: borderColor ?? AppColors.white)
              : null,
          borderRadius: borderRadius != null
              ? BorderRadius.all(
                  Radius.circular(borderRadius ?? 12),
                )
              : null,
          boxShadow: [

            if(shadowRequired!=false)
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
