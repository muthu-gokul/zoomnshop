
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/pages/navHomeScreen.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import 'OrderDeliveryDetails.dart';



class MYOrderDetails extends StatefulWidget {
  VoidCallback voidCallback;
  MYOrderDetails({required this.voidCallback});

  @override
  _MYOrderDetailsState createState() => _MYOrderDetailsState();
}

class _MYOrderDetailsState extends State<MYOrderDetails> {
  @override
  late  double width,height,width2,height2;
  bool openText=false;
  close(){
    Timer(animeDuration, (){
      setState(() {
        openText=false;
      });
    });
  }
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;

    SizeConfig().init(context);
    return SafeArea(
        child: Consumer<ThemeNotifier>(
        builder:(ctx,tn,child)=> Stack(
          children: [
            Scaffold(
              body: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                        height: 100,
                        margin:  EdgeInsets.only(left:15.0,right: 15.0),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:(){
                                widget.voidCallback();
                           },
                                child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Image.asset('assets/images/loginpages/menu-icon.png',height: 30,fit: BoxFit.cover,width: 50,)
                                )
                            ),
                            SizedBox(width: 5,),
                            Text('Order History',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                            Spacer(),
                            GestureDetector(
                              onTap:(){
                                testBtmSheet();
                              },
                                child: Icon(Icons.search_sharp,color:Colors.black,size: 30,))
                          ],
                        ),
                      ),
                     // SizedBox(height:20,),
                      Align(
                        alignment: Alignment.center,
                        child: InnerShadowTBContainer(
                          height: SizeConfig.screenHeight!-154,
                          width:width*0.95,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 7,
                              itemBuilder: (ctx,i){
                                return Column(
                                  children: [
                                    // SizedBox(height: 20,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderDeliveryDetails()));
                                      },
                                      child: Container(
                                        width: width,
                                        margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 15),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color:Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFE1E7F3).withOpacity(0.9),
                                              blurRadius: 20.0, // soften the shadow
                                              spreadRadius: 0.0, //extend the shadow
                                              offset: Offset(
                                                0.0,// Move to right 10  horizontally
                                                10.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          // border: Border.all(color:text1.withOpacity(0.2),),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0XFFFED2DF),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Image.asset('assets/images/loginpages/Clothes.png',height: 50,fit: BoxFit.cover,),
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.center,
                                                children: [
                                                  Text('Saravana Store ',style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                                  SizedBox(height: 5,),
                                                  Text('01-09-2022 / 9.30 AM'
                                                    ,style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                                  SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child:  Text('13,450',style: TextStyle(fontFamily: 'RB',fontSize: 18,color:tn.primaryColor,letterSpacing: 0.1),),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                          }),
                          ),
                      ),
                       SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )

        )
    );
  }

  void testBtmSheet() {
    Get.bottomSheet(
      Container(
          height: SizeConfig.screenHeight!*0.9,
          color: Colors.white,
          child:Column(
            children: [
              Container(
                height: 250,
                  child: Image.asset('assets/images/loginpages/call-acpt.png')),
              Text('Video Shopping to Start in',style: TextStyle(fontFamily: 'RR',fontSize: 20,color:Colors.black26,),),
              SizedBox(height: 10,),
              Text('00:00 Min',style: TextStyle(fontFamily: 'RB',fontSize: 24,color:Color(0XFFFE316C)),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                },
                child: Container(
                  height: 60,
                  width: SizeConfig.screenWidth!*0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0XFFFE316C),
                  ),
                  alignment: Alignment.center,
                  child: Text("Call",style: whiteRM20,),
                ),
              ),
              SizedBox(height: 10,),
              Text('Reject',style: TextStyle(fontFamily: 'RB',fontSize: 24,color:Color(0XFFFE316C)),),
            ],
          )
      ),
      //barrierColor: Colors.red[50],
      isDismissible: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          // side: BorderSide(
          //     width: 5,
          //     color: Colors.black
          // )
      ),
      enableDrag: false,

    );
  }
}
addRemoveBtn(Widget icon){
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color:Color(0xffF5F4F2),
        borderRadius:BorderRadius.circular(5)
    ),
    child: Center(
      child: icon,
    ),
  );
}