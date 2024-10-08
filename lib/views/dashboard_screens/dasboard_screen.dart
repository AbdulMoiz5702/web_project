import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:website_project/controlles/dashboard_controller.dart';
import 'package:website_project/services/firestore_services.dart';
import 'package:website_project/views/deposit_screen/deposit_screen.dart';
import '../../consts/colors.dart';
import '../../consts/list_Strings.dart';
import '../../helpers/main_container.dart';
import '../../reusables/Rounder_buttons.dart';
import '../../reusables/custom_sizedBox.dart';
import '../../reusables/seconday_rounded_button.dart';
import '../../reusables/text_widgets.dart';
import '../referal_bonus_button/referal_bonous_button.dart';
import '../total_teams/total_teams_buttom.dart';

class DashBoardScreen extends StatelessWidget {
  final String currentUserId;
  const DashBoardScreen({this.currentUserId = ''});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashboardController());
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
                  controller.name.value = data['name'];
                  controller.userId.value = data['id'];
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
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
                                    height: 0.005,
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
                                          title: 'REFER BY',
                                          color: whiteColor.withOpacity(0.5),
                                          fontWeight: FontWeight.w400),
                                      Sized(
                                        width: 0.02,
                                        height: 0,
                                      ),
                                      Icon(Icons.person_pin, color: whiteColor),
                                    ],
                                  ),
                                  Sized(
                                    height: 0.005,
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
                                  data['referredByName'] == 'none'? smallText(title: 'No referral', color: whiteColor,) :  largeText(title: data['referredByName'], color: whiteColor,fontSize: 18),
                                ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            mediumText(title: 'Account Balance :',color: whiteColor,fontWeight: FontWeight.bold,fontSize: 15),
                            Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryTextColor,
                              ),
                              child: mediumText(title: ' Rs: ${data['wallet'].toString()}  ',color: whiteColor,fontWeight: FontWeight.bold,fontSize: 18),
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
            height: 0.61,
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButton(title: 'DEPOSIT',imagePath: depositImage,onTap: (){
                      Get.to(()=> DepositScreen());
                    },color: whiteColor,textcolor: blueColor,),
                    RoundedButton(title: 'WITHDRAW',imagePath: withdrawImage,onTap: (){},color: whiteColor,textcolor: blueColor,),
                    RoundedButton(title: 'INVITE',imagePath: inviteImage,onTap: (){
                      print(controller.name.value);
                      print(controller.userId.value);
                      var encodedUsername = Uri.encodeComponent(controller.name.value);
                      final referralLink = 'https://website-4fa8c.web.app/?referrerId=${controller.userId.value}&username=$encodedUsername';
                      controller.copyToClipboard(referralLink, context);
                    },color: whiteColor,textcolor: blueColor,),
                  ],
                ),
              ),
              MainContainer(
                height: 0.45,
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
                          ReferalBonousButton(userId:currentUserId,),
                          TotalTeamsButton(userId: currentUserId,),
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
