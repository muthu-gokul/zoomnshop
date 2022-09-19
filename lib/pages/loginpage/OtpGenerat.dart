import 'package:flutter/material.dart';

import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import 'EnterEmail.dart';
import 'EnterPhone.dart';



class OtpGenerat extends StatefulWidget {
  const OtpGenerat({Key? key}) : super(key: key);

  @override
  _OtpGeneratState createState() => _OtpGeneratState();
}

class _OtpGeneratState extends State<OtpGenerat> {
  @override
  late  double width,height,width2;
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/loginpages/otp.png', width: 300,fit: BoxFit.cover,),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: SizeConfig.screenWidth!*0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Color(0XFF212B3B)),),
                        Text("One 0f the Two",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Color(0XFF212B3B)),),
                        SizedBox(height: 10,),
                        Container(
                          child: Text("Receive your OTP for Login either via  Mail or SMS :",style: ts16(Color(0XFF7D7D7D)),textAlign: TextAlign.left,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneNoPage()),);

                    },
                    child: Container(
                      width: SizeConfig.screenWidth!*0.90,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0XFFF6F6F6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.screenWidth!*0.40,
                              alignment: Alignment.center,
                              child: Icon(Icons.mobile_friendly, color: Color(0XFF272727),size: 60,)),
                          Container(
                            width: SizeConfig.screenWidth!*0.50,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text('Via sms :',style:ts18(Color(0xff151515),), ),
                                Container(
                                  child: Text.rich(
                                    TextSpan(
                                        text: '*** ***',style: ts18(Color(0XFF999999),fontfamily: 'RB'),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: ' 8610',
                                            style: ts18(Color(0XFF1F1F1F),fontsize: 30,fontfamily: 'RB'),
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailPage()),);

                    },
                    child: Container(
                      width: SizeConfig.screenWidth!*0.90,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0XFFF6F6F6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.screenWidth!*0.40,
                              alignment: Alignment.center,
                              child: Icon(Icons.mail_outline, color: Color(0XFF272727),size: 60,)),
                          Container(
                            width: SizeConfig.screenWidth!*0.50,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text('Via mail :',style:ts18(Color(0xff151515),), )),
                                Container(
                                  child: Text.rich(
                                    TextSpan(
                                        text: '*** ***',style: ts18(Color(0XFF999999),fontfamily: 'RB'),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: ' @gmail',
                                            style: ts18(Color(0XFF1F1F1F),fontsize: 30,fontfamily: 'RB'),
                                          )
                                        ]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
