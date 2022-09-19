
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customTextField.dart';
import 'OtpGenerat.dart';
import 'mail-otp/otp_screen.dart';




class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0Xffffffff),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30),
                  width: SizeConfig.screenWidth!*0.9,
                 child: Image.asset('assets/images/loginpages/mail.png', width:SizeConfig.screenWidth!*0.9,fit: BoxFit.cover,),
                ),
                SizedBox(height: 20,),
                Container(
                  width: SizeConfig.screenWidth!*0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter E-mail",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Color(0XFF212B3B)),),
                      Text("Address",style: TextStyle(fontSize: 30,fontFamily: 'RB',color: Color(0XFF212B3B)),),
                      SizedBox(height: 10,),
                      Container(
                        child: Text("Please enter Your Email Address To Receive a Verification Code.",style: ts16(Color(0XFF7D7D7D)),textAlign: TextAlign.left,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Column(
                    children: [
                      AddNewLabelTextField(
                        labelText: 'Enter Email',
                        onChange: (v){},
                        onEditComplete: (){

                          FocusScope.of(context).unfocus();

                          // node.unfocus();
                        },
                        ontap: (){},
                        // textEditingController: invoiceNotifier.customerName,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpGenerat()),);

                            },
                            child: Text('Try AnotherWay',style: TextStyle(fontSize: 18,fontFamily: 'RB',color: Color(0XFFFE316C)),)),
                      ],
                    )
                ),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: (){

                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MailScreen()),);//


                  },
                  child: Container(
                    height: 60,
                    width: SizeConfig.screenWidth!*0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0XFFFE316C),
                    ),
                    alignment: Alignment.center,
                    child: Text("Send",style: whiteRM20,),
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
