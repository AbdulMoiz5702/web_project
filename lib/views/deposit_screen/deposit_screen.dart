import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:website_project/reusables/toast_class.dart';


class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  TextEditingController paymentAmountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Color primaryColor = Color(0xff290D4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.0),
          TextFormField(
            controller: accountNumberController,
            decoration: InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: paymentAmountController,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              if (accountNumberController.text.isEmpty) {
                ToastClass.showToastClass(context: context, message: "Please enter account number");
              } else if (emailController.text.isEmpty) {
                ToastClass.showToastClass(context: context, message: "Please enter email");
              } else if (paymentAmountController.text.isEmpty) {
                ToastClass.showToastClass(context: context, message:"Please enter amount");
              } else {
                print("On Tapped");
                // makePayment();
              }
            },
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void makePayment() async {
  //   try{
  //     Response response = await EasypaisaFlutter.requestPayment(
  //       amount: paymentAmountController.text.trim(),
  //       accountNo: accountNumberController.text.trim(),
  //       email: emailController.text.trim(),
  //     );
  //     print(response.body);
  //   }catch(e,s){
  //     print(e);
  //     print(s);
  //   }
  // }
}
