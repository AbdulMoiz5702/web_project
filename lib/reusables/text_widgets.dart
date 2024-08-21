import 'package:flutter/material.dart';

import '../consts/colors.dart';

Widget largeText(
    {required String title,
    context,
    double fontSize = 22,
    fontWeight = FontWeight.bold,
      color = primaryTextColor,
    }) {
  return Text(
    title,
    style: TextStyle(
        fontSize:  fontSize,
        fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

Widget mediumText(
    {required String title,
      context,
      double fontSize = 18,
      fontWeight = FontWeight.bold,
     Color color = primaryTextColor,
    }) {
  return Text(
    title,
    style: TextStyle(
      fontSize:  fontSize,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}


Widget smallText(
    {required String title,
      context,
      double fontSize = 12,
      fontWeight = FontWeight.w400,
      color = secondaryTextColor,
      double height = 0.5,
    }) {
  return Text(
    title,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height.toDouble(),
    ),
    softWrap: true,
    maxLines: 10, // Adjust the number of lines you want before truncation
    overflow: TextOverflow.ellipsis, // Handles overflow by displaying ellipsis
  );
}
