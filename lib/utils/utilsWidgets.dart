import 'package:flutter/material.dart';
import '../styles/style.dart';
import 'colorUtil.dart';

class AcceptRejectBtn extends StatelessWidget {
  String title;
  VoidCallback ontap;
  AcceptRejectBtn({required this.title,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 30,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: title=="Accept"?Colors.green:Colors.red,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Text(title,style: ts14(Colors.white),),
      ),
    );
  }
}
class CallBtn extends StatelessWidget {
  VoidCallback ontap;
  CallBtn({required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Icon(Icons.call,color: ColorUtil.primaryColor,size: 40,),
      ),
    );
  }
}