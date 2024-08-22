import 'package:flutter/material.dart';
import 'package:website_project/consts/colors.dart';


class MainContainer extends StatelessWidget {
  final double height ;
  final double width ;
  final Color color ;
  final Widget child ;
  const MainContainer({this.height = 0.4,this.width = 1,this.color = blueColor,required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: blueColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        color: color,
        height: MediaQuery.sizeOf(context).height * height,
        width: MediaQuery.sizeOf(context).width * width,
        child: child,
      )
    );
  }
}
