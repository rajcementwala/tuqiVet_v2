import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/container_box.dart';

class StatusBarView extends StatelessWidget {
  const StatusBarView({
    this.color = AppColors.white,
    super.key,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ContainerBox(
      color: color,
      height: MediaQuery.of(context).viewPadding.top,
      child: Container(),
    );
  }
}
