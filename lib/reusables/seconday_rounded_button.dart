import 'package:flutter/material.dart';
import 'package:website_project/reusables/custom_sizedBox.dart';
import 'package:website_project/reusables/text_widgets.dart';
import '../consts/colors.dart';

class SecondaryRoundedButton extends StatelessWidget {
  final String wallet;
  final String title ;
  final String subTitle ;
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
  const SecondaryRoundedButton(
      {this.textcolor = whiteColor,
        this.fontsize = 15,
        this.fontWeight = FontWeight.w700,
        this.elevation = 0,
        required this.wallet,
        required this.onTap,
        this.height = 0.19,
        this.width = 0.28,
        this.color = blueColor,
        required this.imagePath,
        this.isBorder = false,
        required this.title,
        required this.subTitle,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height * height,
        width: MediaQuery.sizeOf(context).width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(color: primaryTextColor.withOpacity(0.5),offset: Offset(0.1,2 ),blurRadius: 3,spreadRadius: 3)
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(imagePath,height: MediaQuery.sizeOf(context).height * 0.09,width:MediaQuery.sizeOf(context).width * 0.1,)),
            smallText(title: title,color: textcolor,),
            Sized(height: 0.01,),
            smallText(title: subTitle,color: textcolor,),
            Sized(height: 0.01,),
            mediumText(
                title: wallet,
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
