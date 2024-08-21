import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../consts/colors.dart';

class CustomIndicator extends StatelessWidget {
  final Color color;
  final double radius ;
  const CustomIndicator({this.color = blueColor,this.radius = 0.03});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
