// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/enum.dart';
import '../../core/utils/utils_import.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    required this.textEditingController,
    this.placeHolder,
    this.labelText,
    this.inputFormatters,
    this.isEnabled = true,
    this.keyboardType,
    this.type = TextFieldType.divider,
    this.prefixIcon,
    this.maxLines = 1,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.maxLength,
    this.fillColor,
    this.isValid,
    super.key,
    this.suffixIcon,
    this.onChanged,
  });

  final bool isEnabled;
  final String? placeHolder;
  final String? labelText;
  final TextEditingController textEditingController;
  final TextFieldType type;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final Color? fillColor;
  final bool? isValid;
  final ValueChanged<String>? onChanged;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with SingleTickerProviderStateMixin {
  // String? _labelText;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _onChangeText(widget.textEditingController.text);
    // });
  }

  @override
  void dispose() {
    widget.focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      enabled: widget.isEnabled,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      autofocus: false,

      textAlign: TextAlign.start,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: TextInputAction.done,
      controller: widget.textEditingController,
      inputFormatters: widget.inputFormatters,
      style: _textStyle,
      maxLines: widget.maxLines,
      validator: widget.validator,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        prefixIcon: _prefixIcon,
        hintText: widget.placeHolder,
        hintStyle: AppFontTextStyles.textNormal.copyWith(
          fontSize: 14,
          color: AppColors.hintTextColor,
        ),
        suffixIconConstraints: const BoxConstraints(
            minHeight: 8,
            minWidth: 8
        ),
        prefixIconConstraints:  const BoxConstraints(
            minHeight: 8,
            minWidth: 8
        ),
        suffixIcon: widget.suffixIcon,
        filled: _filled,
        fillColor: widget.fillColor ?? fillColor,
        labelText: widget.labelText,
        contentPadding: contentPadding,
        labelStyle: _labelStyle,
        border:widget.isValid==false?_getErrorInputBorder: _inputBorder,
        enabledBorder: _inputBorder,
        disabledBorder: _inputBorder,
        focusedBorder: _focusInputBorder,
      ),
    );
  }

  // String? get labelText {
  //   switch (widget.type) {
  //     case TextFieldType.divider:
  //       return _labelText;
  //     default:
  //       return null;
  //   }
  // }

  TextStyle? get _textStyle {
    switch (widget.type) {
      case TextFieldType.borderBox:
        return AppFontTextStyles.textNormal.copyWith(
          fontSize: 16,
          color: AppColors.blackTextColor,
        );
      default:
        return AppFontTextStyles.textNormal.copyWith(
          fontSize: 16,
          color: AppColors.blackTextColor,
        );
    }
  }

  Widget? get _prefixIcon {
    if (widget.prefixIcon != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          child: widget.prefixIcon,
        ),
      );
    }
    return null;
  }

  EdgeInsetsGeometry? get contentPadding {
    switch (widget.type) {
      case TextFieldType.divider:
        return const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        );
      case TextFieldType.borderBox:
        return const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        );
      case TextFieldType.borderOnly:
        return const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        );
    }
  }

  Color? get fillColor {
    switch (widget.type) {
      case TextFieldType.divider:
        return Colors.transparent;
      case TextFieldType.borderBox:
        return Colors.white;
      case TextFieldType.borderOnly:
        return Colors.transparent;
    }
  }

  bool get _filled {
    switch (widget.type) {
      case TextFieldType.divider:
        return false;
      case TextFieldType.borderBox:
        return true;
      case TextFieldType.borderOnly:
        return true;
    }
  }

  TextStyle? get _labelStyle {
    switch (widget.type) {
      case TextFieldType.divider:
        return AppFontTextStyles.textNormal.copyWith(
          color: AppColors.hintTextColor,
          fontSize: 15,
        );
      case TextFieldType.borderBox:
        return AppFontTextStyles.textNormal.copyWith(
          fontSize: 16,
          color: AppColors.hintTextColor,
        );
      case TextFieldType.borderOnly:
        return null;
    }
  }

  InputBorder? get _inputBorder {
    switch (widget.type) {
      case TextFieldType.divider:
        return UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        );

      case TextFieldType.borderBox:
        return OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            14,
          ),
        );

      case TextFieldType.borderOnly:
        return OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            Dimens.radius_small,
          ),
        );
    }
  }

  InputBorder? get _getErrorInputBorder {
   return UnderlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.errorColor,
      ),
      borderRadius: BorderRadius.circular(
        8,
      ),
    );

  }

  InputBorder? get _focusInputBorder {
    switch (widget.type) {
      case TextFieldType.divider:
        return UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        );

      case TextFieldType.borderBox:
        return OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary2,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        );

      case TextFieldType.borderOnly:
        return OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
            style: BorderStyle.solid,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(
            Dimens.radius_small,
          ),
        );
    }
  }

// void _onChangeText(String text) {
//   switch (widget.type) {
//     case TextFieldType.divider:
//       setState(() {
//         if (text.isNotEmpty) {
//           _labelText = widget.placeHolder;
//         } else {
//           _labelText = null;
//         }
//       });
//       break;
//     default:
//   }
// }
}
