import 'package:flutter/material.dart';
import 'package:website_project/reusables/text_widgets.dart';
import '../consts/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double elevation;
  final FontWeight fontWeight;
  final double fontsize;
  final Color color;
  final Color textcolor;
  final String imagePath;
  final bool isBorder ;
  const RoundedButton(
      {this.textcolor = whiteColor,
      this.fontsize = 15,
      this.fontWeight = FontWeight.w700,
      this.elevation = 0,
      required this.title,
      required this.onTap,
      this.height = 0.12,
      this.width = 0.28,
      this.color = blueColor,
        required this.imagePath,
        this.isBorder = false,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height * height,
        width: MediaQuery.sizeOf(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath,height: MediaQuery.sizeOf(context).height * 0.09,width:MediaQuery.sizeOf(context).width * 0.1,),
            mediumText(
                title: title,
                context: context,
                fontSize: fontsize,
                fontWeight: fontWeight,
                color: textcolor),
          ],
        ),
      ),
    );
  }
}
