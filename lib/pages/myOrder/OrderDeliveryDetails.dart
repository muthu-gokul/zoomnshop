
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/pages/HomePage/LandingPage.dart';
import 'package:zoomnshop/pages/customer/OrderSuccess.dart';

import '../../notifier/customer/orderHistoryNotifier.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/colorUtil.dart';
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
                                        child: Obx(() => Text('${orderHistoryController.orderHistoryProductList.length} ITEMS',style: TextStyle(fontFamily: 'RR',fontSize: 18,color: Colors.black38,letterSpacing: 0.1),)),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(() => ListView.builder(
                            physics: BouncingScrollPhysics(),
                            //shrinkWrap: true,
                            itemCount: orderHistoryController.orderHistoryProductList.length,
                            itemBuilder: (ctx,i){
                              return  Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: width*0.95,
                                //height:132,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /* Container(
                                        margin:EdgeInsets.only(right: 20),
                                        child: Image.asset("assets/images/landingPage/slice-02.jpg",fit:BoxFit.cover,height: 120,),
                                      ),*/
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text('${orderHistoryController.orderHistoryProductList[i]['ProductName']}'
                                              ,style: TextStyle(fontFamily: 'RR',fontSize: 15,color: ColorUtil.black),),
                                          ),
                                          //SizedBox(height: 10,),
                                          /*Text('₹ 90.00'
                                              ,style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,letterSpacing: 0.1),
                                            ),*/
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Container(
                                                //height: 40,
                                                //width: 40,
                                                alignment: Alignment.center,
                                                padding:EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  color:Color(0xffffffff),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.black12, //                   <--- border color
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  child: Text("${orderHistoryController.orderHistoryProductList[i]['Quantity']} x",style: gridTextColor15 ,),
                                                ),
                                              ),

                                            ],

                                          ),
                                          /*  SizedBox(height: 10,),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEADCF6),
                                                  shape: BoxShape.circle
                                              ),
                                              child: Text("M",style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Color(0xff67517F),letterSpacing: 0.1)),
                                            ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
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
                                Text('Total Qty:',style: TextStyle(fontFamily: 'RR',fontSize:16,color: Colors.black26,letterSpacing: 0.1),),
                                SizedBox(height: 5,),
                                Obx(() => Text('${orderHistoryController.totalQty.value}'
                                  ,style: TextStyle(fontFamily: 'RB',fontSize: 24,color: Colors.black,letterSpacing: 0.1),)),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Spacer(),
                   /* GestureDetector(
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
                    ),*/
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