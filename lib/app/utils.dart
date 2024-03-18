import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Utils {
  static String _strAppVersion = '';

  static void printJson(String input) {
    if (kDebugMode) {
      var decoded = const JsonDecoder().convert(input);
      var prettyJson = const JsonEncoder.withIndent(' ').convert(decoded);
      dev.log(prettyJson);
    }
  }

  static isPlatformAndroid() {
    return Platform.isAndroid;
  }

  static EdgeInsets getStatusBarSize(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Brightness getCurrentAppTheme(context) {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  static getAppTextTheme(context) {
    return Theme.of(context).textTheme;
  }

  static void dismissKeypad(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isKeypadOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }

  // Print only in debug builds
  static printLogs(dynamic strData) {
    if (kDebugMode) {
      print(strData);
    }
  }

  //number text field
  static bool phoneNumberValidate(String phoneNumber, int length) {
    return phoneNumber.length == length;
  }

  static setAppVersion(String strAppVersion) {
    _strAppVersion = strAppVersion;
  }

  static getAppVersion() {
    return _strAppVersion;
  }

  static bool isSvg(String assetPath) {
    if (assetPath.isNotEmpty && assetPath.toLowerCase().contains(".svg")) {
      return true;
    }
    return false;
  }
}
