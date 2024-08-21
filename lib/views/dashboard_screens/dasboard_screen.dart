import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:website_project/services/firestore_services.dart';

import '../../consts/colors.dart';
import '../../consts/list_Strings.dart';
import '../../reusables/custom_button.dart';
import '../../reusables/custom_indicator.dart';
import '../../reusables/custom_sizedBox.dart';
import '../../reusables/text_widgets.dart';

class Dashboardscreen extends StatelessWidget {
  final currentUserid;
  const Dashboardscreen({required this.currentUserid});

  @override
  Widget build(BuildContext context) {
    if (currentUserid.isEmpty) {
      return Center(child: Text('Invalid User ID'));
    }
    print('user id $currentUserid');
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Sized(
                    width: 0.00920,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/logo1.png')),
                    ),
                  ),
                  Sized(
                    width: 0.0220,
                  ),
                  Row(
                      children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                      child: CustomButton(
                        width: 0.1,
                          fontsize: 14.0,
                          fontWeight: FontWeight.normal,
                          textcolor: primaryTextColor.withOpacity(0.8),
                          color: tabbarbuttonColor[index],
                          title: tabbarbutton[index].toString(), onTap: () {}),
                    );
                  })),

                ],
              ),
              Row(
                children: [
                  Row(
                      children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                      child: CustomButton(

                        color: tabbarsignupcolor[index],
                        textcolor: tabbarsignuptextcolor[index],

                        height: 0.07,
                        width: 0.1,
                          fontsize: 15.0,
                          fontWeight: FontWeight.w700,

                          elevation: 5.0,
                          title: tabbarsignupbutton[index].toString(), onTap: () {}),
                    );
                  })),

                  Sized(
                    width: 0.0220,
                  ),
                ],
              ),


            ],
          ),
          // StreamBuilder<DocumentSnapshot>(
          //     stream: FirestoreServices.getUserInformation(currentUserid),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CustomIndicator();
          //       } else if (snapshot.hasData) {
          //         var data = snapshot.data!.data() as Map<String, dynamic>;
          //         return Padding(
          //           padding: const EdgeInsets.all(15.0),
          //           child: SingleChildScrollView(
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Sized(
          //                   height: 0.00922,
          //                 ),
          //
          //                 mediumText(title: 'Hi ${data['name']}'),
          //                 Sized(
          //                   height: 0.0092,
          //                 ),
          //                 // Row(
          //                 //   children: [
          //                 //     smallText(title: 'Phone',color: blueColor),
          //                 //     mediumText(title: data['phone'])
          //                 //   ],
          //                 // ),
          //                 // Sized(height: 0.0092,),
          //               ],
          //             ),
          //           ),
          //         );
          //       } else {
          //         return Center(
          //           child: largeText(
          //               title: 'Please Visit admin to resolve the issue'),
          //         );
          //       }
          //     }),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/earning1.jpg'))
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
