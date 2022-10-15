
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/pages/HomePage/LandingPage.dart';
import 'package:zoomnshop/pages/HomePage/OrderSuccess.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';



class OrderDeliveryDetails extends StatefulWidget {
  const OrderDeliveryDetails({Key? key}) : super(key: key);

  @override
  _OrderDeliveryDetailsState createState() => _OrderDeliveryDetailsState();
}

class _OrderDeliveryDetailsState extends State<OrderDeliveryDetails> {
  @override
  late  double width,height,width2,height2;
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
              backgroundColor: Colors.white,
              body: Container(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Container(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 25,),
                                  decoration: BoxDecoration(
                                      color: tn.primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: tn.primaryColor.withOpacity(0.9),
                                          blurRadius: 10.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            0.0,// Move to right 10  horizontally
                                            5.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: IconButton(onPressed: (){
                                    Get.back();
                                  }, icon: Icon(Icons.arrow_back_ios_sharp,color:Colors.white,size: 20,),),
                                ),
                                Container(
                                  width: SizeConfig.screenWidth!*0.65,
                                  padding: EdgeInsets.only(top: 20),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text('Your Bag',style: TextStyle(fontFamily: 'RR',fontSize: 30,color: Colors.black,letterSpacing: 0.1),),
                                      ),
                                      SizedBox(height: 5,),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text('7 ITEMS',style: TextStyle(fontFamily: 'RR',fontSize: 18,color: Colors.black38,letterSpacing: 0.1),),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   // SizedBox(height:20,),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin:EdgeInsets.only(left:15.0,right: 15.0) ,
                        padding: EdgeInsets.only(top: 10),
                        height: 430,
                        width:width*0.95,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (ctx,i){
                          return  Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: width*0.95,
                            height:132,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:EdgeInsets.only(right: 20),
                                      child: Image.asset("assets/images/landingPage/slice-02.jpg",fit:BoxFit.cover,height: 120,),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text('The  North Face 100 Glacier 1/4 zip'
                                            ,style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black),),
                                        ),
                                        SizedBox(height: 10,),
                                        Text('₹ 90.00'
                                          ,style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,letterSpacing: 0.1),),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // addRemoveBtn(Icon(Icons.add,color: tn.primaryColor,size: 25,)),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color:Color(0xffffffff),
                                                  shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black12, //                   <--- border color
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5,right: 5),
                                                child: Text("1X",style: gridTextColor15 ,),
                                              ),
                                            ),
                                            // addRemoveBtn(Icon(Icons.remove,color: tn.primaryColor,size: 25,)),
                                          ],

                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0xffEADCF6),
                                              shape: BoxShape.circle
                                          ),
                                          child: Text("M",style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Color(0xff67517F),letterSpacing: 0.1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        ),
                    ),
                    Container(
                      margin:  EdgeInsets.only(left:5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10,top: 30),
                            decoration: BoxDecoration(
                                color: Color(0XFFF5F6FA),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/icons/ongoingorder.svg',height: 30,color: Colors.black,fit: BoxFit.cover,),
                                Text('FREE',style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                ]
                            ),
                          ),
                          Container(
                            width: SizeConfig.screenWidth!*0.65,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide( //                    <--- top side
                                color: Color(0XFFF5F6FA),
                              ),
                              ),
                              ),
                            margin: EdgeInsets.only(left: 30,top: 30),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Total :',style: TextStyle(fontFamily: 'RR',fontSize:16,color: Colors.black26,letterSpacing: 0.1),),
                                SizedBox(height: 5,),
                                Text('₹ 300.00'
                                  ,style: TextStyle(fontFamily: 'RB',fontSize: 24,color: Colors.black,letterSpacing: 0.1),),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderSuccessful()),);
                      },
                      child: Container(
                        height: 60,
                        width: SizeConfig.screenWidth!*0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0XFFA0C79A),
                        ),
                        alignment: Alignment.center,
                        child: Text("Delivered On 12-09-2022 / 9.30 AM",style: TextStyle(fontFamily: 'RR',fontSize:16,color: Color(0XFF38862C),letterSpacing: 0.1),),
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),

            ),
          ],
        )

        )
    );
  }
}
addRemoveBtn(Widget icon){
  return Container(
    height: 25,
    width: 25,
    // decoration: BoxDecoration(
    //     color:Color(0xffF5F4F2),
    //     borderRadius:BorderRadius.circular(5)
    // ),
    child: Center(
      child: icon,
    ),
  );
}