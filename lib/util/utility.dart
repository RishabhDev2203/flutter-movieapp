import 'dart:async';
import 'dart:io' as IO;
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:package_info/package_info.dart';
import 'app_colors.dart';
import 'dimensions.dart';
import 'package:intl/intl.dart';


class Utility {
  static showAlertDialogUploading(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Uploading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  static Future<String> deviceType() async {
    var platformName = "web";
    if (IO.Platform.isAndroid) {
      platformName = "Android";
    } else if (IO.Platform.isIOS) {
      platformName = "IOS";
    }
    return platformName;
  }

  static Future<String> appVerson() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  static Future<String> deviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model.toString();
  }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (IO.Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static String capitalized(String word) {
      return word.length > 1 ? "${word[0].toUpperCase()}${word.substring(1)}" : word;
  }

  static void hideLoader(BuildContext context) {
    if (context.loaderOverlay
        .visible /* && context.loaderOverlay.overlayWidgetType == ReconnectingOverlay*/) {
      context.loaderOverlay.hide();
    }
  }

  static void showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static showAlertDialog(BuildContext context, String msg) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.white,
      content: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg,
              style: const TextStyle(
                  fontSize: Dimensions.textSizeMedium, color: AppColors.black),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: Dimensions.textSizeMedium),
                  ),
                )),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static String convertDateToFormat(String data) {
    if (data == null || data.isEmpty) return "";
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd").parse(data, true);
    var dateLocal = parseDate.toLocal();
    var inputDate = DateTime.parse(dateLocal.toString());
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
  static String convertFormat(String data) {
    if (data == null || data.isEmpty) return "";
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(data, true);
    var dateLocal = parseDate.toLocal();
    var inputDate = DateTime.parse(dateLocal.toString());
    var outputFormat = DateFormat('dd MMM yyyy hh:mm aa');
    var outputDate = outputFormat.format(inputDate);
    return outputDate+' GMT';

  }

  static String timeAgoWithTime(String dateString,
      {bool numericDates = false}) {
    if (dateString == null || dateString.isEmpty) return "";
    DateTime notificationDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(dateString, true);
    DateTime date =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(dateString, true);
    var dateLocal = date.toLocal();
    var inputDate = DateTime.parse(dateLocal.toString());
    var outputTimeFormat = DateFormat('hh:mm a');
    var outputDateFormat = DateFormat('dd MMM yyyy');
    var outputTime = outputTimeFormat.format(inputDate);
    var outputDate = outputDateFormat.format(inputDate);
    final date2 = DateTime.now().toUtc();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 1440) {
      return '$outputDate | $outputTime';
    } else if ((difference.inDays / 60).floor() >= 1) {
      return (numericDates)
          ? '$outputDate | $outputTime'
          : '$outputDate | $outputTime';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates)
          ? '$outputDate | $outputTime'
          : '$outputDate | $outputTime';
    } else if ((difference.inDays / 15).floor() >= 1) {
      return (numericDates)
          ? '$outputDate | $outputTime'
          : '$outputDate | $outputTime';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates)
          ? '1 week ago | $outputTime'
          : 'Last week | $outputTime';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago | $outputTime';
    } else if (difference.inDays >= 1) {
      return (numericDates)
          ? '1 day ago | $outputTime'
          : 'Yesterday | $outputTime';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago | $outputTime';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String timeAgoWithDays(String dateString,
      {bool numericDates = false}) {
    if (dateString == null || dateString.isEmpty) return "";
    DateTime notificationDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(dateString, true);
    DateTime date =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(dateString, true);
    var dateLocal = date.toLocal();
    var inputDate = DateTime.parse(dateLocal.toString());
    var outputDateFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputDateFormat.format(inputDate);
    final date2 = DateTime.now().toUtc();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 1440) {
      return '$outputDate';
    } else if ((difference.inDays / 60).floor() >= 1) {
      return (numericDates)
          ? '$outputDate'
          : '$outputDate ';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates)
          ? '$outputDate'
          : '$outputDate ';
    } else if ((difference.inDays / 15).floor() >= 1) {
      return (numericDates)
          ? '$outputDate'
          : '$outputDate';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates)
          ? '1 week ago'
          : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates)
          ? '1 day ago'
          : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
