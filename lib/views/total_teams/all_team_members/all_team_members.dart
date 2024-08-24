import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_project/consts/colors.dart';
import 'package:website_project/reusables/custom_indicator.dart';
import 'package:website_project/reusables/text_widgets.dart';
import '../../../controlles/total_team_controller.dart';

class TotalTeamMembersScreen extends StatelessWidget {
  final List<String> userIds;
  TotalTeamMembersScreen({required this.userIds});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TotalTeamController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: controller.getReferredUsersStream(userIds),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomIndicator();
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: mediumText(title: 'No referred users found'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> referredUsers = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: referredUsers.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> user = referredUsers[index];
                  return Container(
                    margin: EdgeInsets.only(top: 5),
                    child: ListTile(
                      leading: const Icon(Icons.person,color: whiteColor,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: primaryTextColor,
                      title: mediumText(title:user['name'],color: whiteColor), // Assuming 'name' is a field in user data
                      subtitle: smallText(title :user['email'],color: whiteColor,fontWeight: FontWeight.bold,fontSize: 11), // Assuming 'email' is a field in user data
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: mediumText(title: 'Check your internet'));
          }
        },
      ),
    );
  }
}
