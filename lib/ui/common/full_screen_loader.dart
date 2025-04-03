import 'package:flutter/material.dart';
import '../../core/utils/dimensions.dart';
import '../../extension/context_extensions.dart';
import 'app_loader.dart';

class FullScreenLoader extends StatelessWidget {
  final double heightOffset;

  const FullScreenLoader(
      {this.heightOffset =
          Dimens.navigation_bar_height + Dimens.top_empty_bar_height,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height - context.safeAreaPadding - heightOffset,
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: Container(
                width: Dimens.loader_size_normal,
                height: Dimens.loader_size_normal,
                child: const AppLoader()),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
