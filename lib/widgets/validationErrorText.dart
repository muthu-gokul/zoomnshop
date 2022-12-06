import 'package:flutter/material.dart';
import 'package:zoomnshop/utils/colorUtil.dart';





class ValidationErrorText extends StatelessWidget {
 final String title;
 double leftPadding;
 double rightPadding;
 ValidationErrorText({this.title="* Required",this.leftPadding=15.0,this.rightPadding=0.0});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: leftPadding,right: rightPadding,top:5),
      child: Align(
        alignment: Alignment.centerLeft,
          child: Text("$title",style: TextStyle(fontSize: 15,color: ColorUtil.red,fontFamily: 'RR'),textAlign: TextAlign.left,)),
    );
  }
}

class EmailValidation{
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }
}