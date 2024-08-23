import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;



class DashboardController extends GetxController{

  void copyToClipboard(String link, BuildContext context) {
    print('link: $link');
    html.window.navigator.clipboard?.writeText(link).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Referral link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('${error.toString()}'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }


// Clipboard.setData(ClipboardData(text: data['id']));
// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text('Referral Code copied to clipboard'),
//     duration: Duration(seconds: 1),
//   ),
// );

}