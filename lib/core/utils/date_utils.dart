// ignore_for_file: avoid_classes_with_only_static_members, avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDate(String date) {
    var dateTime = DateTime.parse(date);
    var formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatDate2(String date) {
    var dateTime = DateTime.parse(date);
    var formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  static String getDurationInMinSec({int? startTimeMs, int? endTimeMs}) {
    try {
      Duration? duration;
      if (startTimeMs != null && endTimeMs != null) {
        var start = DateTime.fromMillisecondsSinceEpoch(startTimeMs);
        var end = DateTime.fromMillisecondsSinceEpoch(endTimeMs);
        duration = end.difference(start);
      } else {
        return '';
      }

      if (duration.inSeconds < 0) {
        return '00:00';
      }
      if (duration.inSeconds < 60) {
        return '${duration.inSeconds} sec';
      }

      String twoDigits(int n) => n.toString().padLeft(1, '0');
      var twoDigitHour = twoDigits(duration.inHours.remainder(60));
      var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      if (duration.inHours > 0) {
        return '$twoDigitHour hour $twoDigitMinutes min';
      }
      return '$twoDigitMinutes min';
    } catch (e) {
      debugPrint('Exception in getDurationInMinSec :$e');
      return '';
    }
  }

  static DateTime getDateFromMillisecondsSinceEpoch({required int millisecondsSinceEpoch}) {
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return date;
  }

  static String getTimeFromMillisecondsSinceEpoch({required int millisecondsSinceEpoch}){
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return DateFormat.jm().format(date);
  }
}
