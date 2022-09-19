import 'package:flutter/material.dart';
import '../../../utils/sizeLocal.dart';
import 'components/body.dart';

class PhoneScreen extends StatelessWidget {
  static String routeName = "/mail-otp";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("OTP Verification"),
        // ),
        body: Body(),
      ),
    );
  }
}
