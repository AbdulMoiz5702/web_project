import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardController extends GetxController {
  void copyToClipboard(String link, BuildContext context) {
    try {
      if (kIsWeb) {
        FlutterClipboard.copy(link).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('Referral link copied to clipboard! $link'),
              duration: Duration(seconds: 2),
            ),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to copy referral link on web: $error $link'),
              duration: Duration(seconds: 2),
            ),
          );
        });
      } else {
        Clipboard.setData(ClipboardData(text: link)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('Referral link copied to clipboard! $link'),
              duration: Duration(seconds: 2),
            ),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to copy referral link on mobile: $error $link'),
              duration: Duration(seconds: 2),
            ),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception while copying referral link: $e $link'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
