import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../notifier/shopKeeper/skCartNotifier.dart';
import '../../api/ApiManager.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/closeButton.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/loader.dart';

class SkCartAppointment extends StatefulWidget {
  VoidCallback voidCallback;
  SkCartAppointment({required this.voidCallback});

  @override
  State<SkCartAppointment> createState() => _SkCartAppointmentState();
}

class _SkCartAppointmentState extends State<SkCartAppointment> {

  @override
  void initState(){

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      skCartController.getCartApp();
    });
    super.initState();
  }


  late  double width,height,width2,height2,gridWidth;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    gridWidth=width-30;
    SizeConfig().init(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                      height: 70,
                      margin:  EdgeInsets.only(left:15.0,right: 15.0),
                      child:  Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
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
                              Text('Cart',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                              Spacer(),
                              RefreshBtn(ontap:  skCartController.getCartApp),


                            ],
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height:20,),
                    Align(
                      alignment: Alignment.center,
                      child: InnerShadowTBContainer(
                        height: SizeConfig.screenHeight!-100,
                        width:width*0.95,
                        child: Obx(() => ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: skCartController.skCartAppList.length,
                            itemBuilder: (ctx,i){
                              return GestureDetector(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderDeliveryDetails()));
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0XFFFED2DF),
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${DateFormat('dd \n MMM').format(DateTime.parse(skCartController.skCartAppList[i]['AppointmentDate']))} ',
                                              style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xffC00135)),textAlign: TextAlign.center,),
                                            // Text('Sep ',style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xffC00135),),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            //AppointmentNumber
                                            Text('#${skCartController.skCartAppList[i]['AppointmentNumber']}',
                                              style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                            SizedBox(height: 5,),
                                            Flexible(child: Text('${skCartController.skCartAppList[i]['ClientOutletName']}',
                                              style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),)),
                                            SizedBox(height: 5,),
                                            Flexible(child: Text('${skCartController.skCartAppList[i]['CustomerName']??""}',style: ColorUtil.primaryText,),),
                                            SizedBox(height: 5,),

                                          ],
                                        ),
                                      ),
                                      CloseBtn(
                                        icon: Icons.shopping_cart_outlined,
                                        iconSize: 25,
                                        height: 50,
                                        onTap: (){
                                          skCartController.getCartDetail(skCartController.skCartAppList[i]['AppointmentId']);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Obx(() => Loader(value: showLoader.value,))
        ],
      ),
    );
  }
}
