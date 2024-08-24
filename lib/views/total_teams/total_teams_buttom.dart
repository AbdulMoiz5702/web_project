import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/list_Strings.dart';
import '../../reusables/seconday_rounded_button.dart';
import '../../services/firestore_services.dart';
import 'all_team_members/all_team_members.dart';

class TotalTeamsButton extends StatelessWidget {
  final String userId;
  const TotalTeamsButton({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireStoreServices.getUserInformation(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Teams',
              wallet: '--/--/-',
              imagePath: totalTeamsImage,
              onTap: () {},
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> totalReference = data['referrals'];
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Teams',
              wallet: totalReference.length.toString(),
              imagePath: totalTeamsImage,
              onTap: () {
                Get.to(()=> TotalTeamMembersScreen(userIds: totalReference.cast<String>(),),);
              },
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          } else {
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Teams',
              wallet: '--/--/-',
              imagePath: totalTeamsImage,
              onTap: () {},
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          }
        });
  }
}
