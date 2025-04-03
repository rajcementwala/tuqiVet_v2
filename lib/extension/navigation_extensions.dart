import 'package:flutter/material.dart';

import '../core/utils/utils_import.dart';
import '../ui/common/app_loader.dart';

extension BuildContextNavigation on BuildContext {
  void pop<T extends Object>([T? result]) => Navigator.of(this).pop(result);

  void popUntil(RoutePredicate predicate) {
    return Navigator.of(this).popUntil(predicate);
  }

  Future<T?> push<T extends Object>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool rootNavigator = false,
  }) {
    return Navigator.of(this, rootNavigator: rootNavigator).push(
      MaterialPageRoute<T>(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  Future<T?> pushTransparent<T extends Object>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    Color? overlayColor,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool rootNavigator = false,
  }) {
    return Navigator.of(this, rootNavigator: rootNavigator).push(
      TransparentRoute<T>(
        builder: builder,
        settings: settings,
        overlayColor: overlayColor,
        updatedFullscreenDialog: fullscreenDialog,
      ),
    );
  }

  Future<T?> pushReplacementTransparent<T extends Object>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    Color? overlayColor,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return Navigator.of(this).pushReplacement(
      TransparentRoute<T>(
        builder: builder,
        settings: settings,
        overlayColor: overlayColor,
        updatedFullscreenDialog: fullscreenDialog,
      ),
    );
  }

  Future<T?> pushReplacement<T extends Object>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) =>
      Navigator.of(this).pushReplacement(
        MaterialPageRoute<T>(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog),
      );

  Future<T?> pushAndRemoveUntil<T extends Object>({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute<T>(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog),
      (route) => false,
    );
  }

  Future<bool> maybePop<T extends Object?>([T? result]) => Navigator.of(this).maybePop(result);

  /* void showToast(Widget child) {
    showToastWidget(
      child,
      context: this,
      duration: TransitionDuration.verySlow,
      animDuration: TransitionDuration.fast,
      animation: StyledToastAnimation.none,
      reverseAnimation: StyledToastAnimation.none,
      position: StyledToastPosition.center,
    );
  } */

  void presentModalBottomSheet({
    required Widget child,
    BoxConstraints? constraints,
    Offset? anchorPoint,
    double? elevation = 0.0,
    Color? backgroundColor = Colors.transparent,
    bool isScrollControlled = true,
    bool isDismissible = true,
    EdgeInsetsGeometry? padding,
  }) {
    showModalBottomSheet(
      elevation: elevation,
      backgroundColor: backgroundColor,
      context: this,
      isScrollControlled: isScrollControlled,
      anchorPoint: anchorPoint,
      constraints: constraints,
      isDismissible: isDismissible,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              child: Container(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                color: AppColors.white,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showAppGeneralDialog({
    required Widget body,
    EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 20),
    EdgeInsets padding = const EdgeInsets.all(20),
  }) async {
    return await showGeneralDialog(
      context: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: insetPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: padding,
            child: body,
          ),
        );
      },
    );
  }

  void showSnackBar(String message, {bool isError = false, Duration? duration, int maxLines = 1}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (isError) ...[
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
            ],
            Expanded(
              child: Text(
                message,
                style: AppFontTextStyles.textNormal.copyWith(fontSize: 16, color: AppColors.black),
                maxLines: maxLines,
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.hardEdge,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: AppColors.borderColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
    );
  }

  void showLoadingDialog({required GlobalKey key, String? message}) async {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLoader(),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    message ?? 'Please wait...',
                    style: AppFontTextStyles.textMedium.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransparentRoute<T> extends PageRoute<T> {
  TransparentRoute({required this.builder, required this.updatedFullscreenDialog, required this.overlayColor, RouteSettings? settings})
      : super(settings: settings, fullscreenDialog: updatedFullscreenDialog);

  final WidgetBuilder builder;
  final bool updatedFullscreenDialog;
  final Color? overlayColor;

  @override
  bool get opaque => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => TransitionDuration.medium;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation.drive(tween);

    return Container(
      color: overlayColor ?? Colors.blue.shade200,
      child: SlideTransition(
        position: offsetAnimation,
        child: result,
      ),
    );
  }
}
