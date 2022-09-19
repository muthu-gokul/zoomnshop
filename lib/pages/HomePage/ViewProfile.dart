import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../utils/sizeLocal.dart';


class ViewProfile extends StatefulWidget {
  // VoidCallback voidCallback;
  // ViewProfile({required this.voidCallback});


  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  GlobalKey <ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
        child:  Consumer<ThemeNotifier>(
          builder:(ctx,tn,child)=> Scaffold(
      body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffF7F7FF),
                    Color(0xffffffff),
                  ],
                )
            ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    clipBehavior:Clip.antiAlias,
                      height: 350,
                      width: width,
                      decoration: BoxDecoration(
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
                      borderRadius: BorderRadius.circular(25),
                    color: Colors.white
                  ),
                  child:Column(
                    children: [
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 30,top: 30),
                            decoration: BoxDecoration(
                                color: tn.primaryColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: IconButton(onPressed: (){
                              Get.back();
                             // scaffoldkey.currentState!.openEndDrawer();

                              // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ThemeSettings()));
                            }, icon: Icon(Icons.arrow_back_ios_sharp,color:Colors.white,size: 20,),),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfile(),));
                                },
                                child: Container(
                                    height: 145,
                                    width: 145,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Image.asset("assets/images/landingPage/avatar-01.jpg")
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: Text('Mr. Balasubramaniyan v'
                              ,style: TextStyle(fontFamily: 'RB',fontSize: 20,color: Colors.black54,letterSpacing: 0.1),),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: SizeConfig.screenWidth!*0.40,
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffFFDCE6),
                                borderRadius: BorderRadius.circular(5)
                              // shape: BoxShape.circle
                            ),
                            child:  Text('90923-22264'
                              ,style: TextStyle(fontFamily: 'RR',fontSize: 16,color:tn.primaryColor,letterSpacing: 0.1),),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                    ],
                  ),
              ),

                  SizedBox(height: 10.0,),

                  Container(
                    margin: EdgeInsets.only(left:20),
                    width: SizeConfig.screenWidth,
                    alignment: AlignmentDirectional.topStart,
                    child: Text('Delivery Details'
                      ,style: TextStyle(fontFamily: 'RB',fontSize: 20,color: Colors.black,letterSpacing: 0.1),),
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      clipBehavior:Clip.antiAlias,
                      height: 100,
                     // width: width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFE1E7F3).withOpacity(0.9),
                              blurRadius: 10.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                0.0,// Move to right 10  horizontally
                                0.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: tn.primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: SvgPicture.asset("assets/images/icons/ongoingorder.svg",color: Colors.white,height: 30,fit: BoxFit.cover,),
                        ),
                        // Expanded(
                        //   child: Text('No:14, NP Developed Plots, TVK Industrial Estate, Ekkattuthangal Chennai-600032'
                        //     ,style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black),),
                        // ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Delivery Address'
                                ,style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,letterSpacing: 0.1),),
                              Flexible(
                                child: Text('No:14, NP Developed Plots, TVK Industrial Estate, Ekkattuthangal Chennai-600032'
                                  ,style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black),),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: SvgPicture.asset("assets/images/icons/edit-icon.svg",color:tn.primaryColor,height: 30,fit: BoxFit.cover,)
                        )
                      ],
                    ),
                  )
                ]
              ),
            )
          ),
        ),
      )
    );
  }
}
