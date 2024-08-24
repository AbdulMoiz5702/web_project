import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../consts/colors.dart';
import '../../consts/list_Strings.dart';
import '../../reusables/seconday_rounded_button.dart';
import '../../services/firestore_services.dart';

class ReferalBonousButton extends StatelessWidget {
  final String userId;
  const ReferalBonousButton({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FireStoreServices.getUserInformation(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Refer Bonus',
              wallet: '--/--/-',
              imagePath: totalBonusImage,
              onTap: () {},
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Refer Bonus',
              wallet: 'RS ${data['referralBonus'].toString()}',
              imagePath: totalBonusImage,
              onTap: () {},
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          } else {
            return SecondaryRoundedButton(
              title: 'Total',
              subTitle: 'Refer Bonus',
              wallet: '--/--/-',
              imagePath: totalBonusImage,
              onTap: () {},
              color: primaryTextColor,
              textcolor: whiteColor,
            );
          }
        });
  }
}
