import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:website_project/services/firestore_services.dart';
import '../../consts/colors.dart';
import '../../consts/list_Strings.dart';
import '../../helpers/main_container.dart';
import '../../reusables/Rounder_buttons.dart';
import '../../reusables/custom_sizedBox.dart';
import '../../reusables/seconday_rounded_button.dart';
import '../../reusables/text_widgets.dart';

class DashBoardScreen extends StatelessWidget {
  final String currentUserId;
  const DashBoardScreen({this.currentUserId = ''});

  @override
  Widget build(BuildContext context) {
    print(currentUserId);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).width * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(headerImage),fit: BoxFit.cover),
            ),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FireStoreServices.getUserInformation(currentUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    width: MediaQuery.sizeOf(context).width * 1,
                    child: Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.black26,
                        child: Sized(
                          height: 0.3,
                          width: 1,
                        )
                    ),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.sizeOf(context).height * 0.25,
                    width: MediaQuery.sizeOf(context).width * 1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: primaryTextColor,width: 3),
                        color: blueColor, boxShadow: [
                      BoxShadow(
                          color: primaryTextColor.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0.5, 4))
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      mediumText(
                                          title: 'USERNAME',
                                          color: whiteColor.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                      Sized(
                                        width: 0.02,
                                        height: 0,
                                      ),
                                      Icon(Icons.person, color: whiteColor),
                                    ],
                                  ),
                                  Sized(
                                    height: 0.01,
                                    width: 0,
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.sizeOf(context).width * 0.3,
                                    color: whiteColor,
                                  ),
                                  Sized(
                                    height: 0.01,
                                    width: 0,
                                  ),
                                  largeText(title: data['name'], color: whiteColor,fontSize: 16),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      mediumText(
                                          title: 'Referral Code :',
                                          color: whiteColor.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                      Sized(
                                        width: 0.02,
                                        height: 0,
                                      ),
                                      IconButton(onPressed: (){
                                        Clipboard.setData(ClipboardData(text: data['id']));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Referral Code copied to clipboard'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }, icon: Icon(Icons.copy, color: whiteColor),)
                                    ],
                                  ),
                                  Sized(
                                    height: 0.01,
                                    width: 0,
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.sizeOf(context).width * 0.3,
                                    color: whiteColor,
                                  ),
                                  Sized(
                                    height: 0.02,
                                    width: 0,
                                  ),
                                  smallText(title: data['id'], color: whiteColor,fontWeight: FontWeight.bold,),
                                ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [

                                      Sized(
                                        width: 0.02,
                                        height: 0,
                                      ),
                                      Icon(Icons.mail, color: whiteColor),
                                    ],
                                  ),
                                  Sized(
                                    height: 0.01,
                                    width: 0,
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.sizeOf(context).width * 0.3,
                                    color: whiteColor,
                                  ),
                                  Sized(
                                    height: 0.01,
                                    width: 0,
                                  ),
                                  largeText(title: data['email'], color: whiteColor,fontSize: 16),
                                ]),
                            Column(
                              children: [
                                mediumText(title: 'Account Balance :',color: whiteColor,fontWeight: FontWeight.bold,fontSize: 15),
                                Sized(height: 0.01,width: 0,),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: whiteColor,
                                  ),
                                  child: mediumText(title: ' Rs ${data['wallet']}  ',color: blueColor,fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: largeText(
                        title: 'Please Visit admin to resolve the issue'),
                  );
                }
              }),
          MainContainer(
            height: 0.615,
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButton(title: 'DEPOSIT',imagePath: depositImage,onTap: (){},color: whiteColor,textcolor: blueColor,),
                    RoundedButton(title: 'WITHDRAW',imagePath: withdrawImage,onTap: (){},color: whiteColor,textcolor: blueColor,),
                    RoundedButton(title: 'INVITE',imagePath: inviteImage,onTap: (){},color: whiteColor,textcolor: blueColor,),
                  ],
                ),
              ),
              MainContainer(
                height: 0.46,
                color: whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecondaryRoundedButton(title: 'Total',subTitle: 'Investment',wallet: 'RS 80',imagePath: totalInvestmentImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                          SecondaryRoundedButton(title: 'Total',subTitle: 'Withdraw',wallet: 'RS 60',imagePath: totalWithdrawImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                          SecondaryRoundedButton(title: 'Total',subTitle: 'Earnings',wallet: 'RS 80',imagePath: totalEarningsImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SecondaryRoundedButton(title: 'Team',subTitle: 'Investment',wallet: 'RS 370',imagePath: teamInvestmentImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                          SecondaryRoundedButton(title: 'Total',subTitle: 'Refer Bonus',wallet: 'RS 70',imagePath: totalBonusImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                          SecondaryRoundedButton(title: 'Total',subTitle: 'Teams',wallet: '7',imagePath: totalTeamsImage,onTap: (){},color: primaryTextColor,textcolor: whiteColor,),
                        ],
                      ),
                    ),
              ],)),
            ],
          ),),
        ],
      ),
    );
  }
}
