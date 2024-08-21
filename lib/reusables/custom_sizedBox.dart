import 'package:flutter/material.dart';

class Sized extends StatelessWidget {
  final double height;
  final double width;
  Sized({this.width = 0.02, this.height = 0.02});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * height,
      width: MediaQuery.sizeOf(context).width * width,
    );
  }
}
