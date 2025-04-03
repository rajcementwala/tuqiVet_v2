// ignore_for_file: avoid_classes_with_only_static_members

import 'utils_import.dart';

class AppValidators{
  static String? cannotEmpty(String? value){
    if (value?.isNotEmpty ?? false) {
      if (value!.trim().isEmpty) {
        return 'Can not be empty';
      } else {
        return null;
      }
    } else {
      return 'Can not be empty';
    }
  }

  static String? emailValidator(String? value){
    if (value?.isNotEmpty ?? false) {
      // const Pattern emailPattern = r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
      var isValid = RegExps.email.hasMatch(value!);
      if (!isValid) {
        return 'Enter a valid email address';
      }
      return null;
    } else {
      return 'Can not be empty';
    }
  }
}