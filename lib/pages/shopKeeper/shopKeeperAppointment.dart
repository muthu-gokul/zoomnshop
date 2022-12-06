import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/api/ApiManager.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/styles/style.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';
import 'package:zoomnshop/widgets/closeButton.dart';
import 'package:zoomnshop/widgets/loader.dart';
import 'package:zoomnshop/widgets/noDataFound.dart';

import '../../notifier/callNotifier.dart';
import '../../notifier/shopKeeper/skAppointmentNotifier.dart';
import '../../notifier/shopKeeper/skCartNotifier.dart';
import '../../notifier/themeNotifier.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../utils/utilsWidgets.dart';
import '../../videoCall/service/managementToken.dart';
import '../../widgets/innerShadowTBContainer.dart';

class ShopKeeperAppointmentDetail extends StatefulWidget {
  VoidCallback voidCallback;
  ShopKeeperAppointmentDetail({required this.voidCallback});

  @override
  _ShopKeeperAppointmentDetailState createState() => _ShopKeeperAppointmentDetailState();
}
class _ShopKeeperAppointmentDetailState extends State<ShopKeeperAppointmentDetail> with TickerProviderStateMixin{



  late  double width,height,width2,height2,gridWidth;
  bool openText=false;

  DateTime? appoDate;



  @override
  void initState(){
    sktabController = TabController(length: 3,  vsync: this);
    sktabController.addListener(() {
      if(!sktabController.indexIsChanging){
        getShopKeeperAppointmentDetail(getAppoiStatusByIndex(sktabController.index));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getShopKeeperAppointmentDetail(getAppoiStatusByIndex(0));
      generateManagementToken();
    });
    super.initState();
  }

  String page="Appointments";

  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    gridWidth=width-30;
    SizeConfig().init(context);
    return SafeArea(
        child: Consumer<ThemeNotifier>(
            builder:(ctx,tn,child)=> Stack(
              children: [
                Scaffold(
                  body: Container(
                    height: height,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Container(
                          height: 120,
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
                                  Text('Appointment',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                                  Spacer(),
                                  RefreshBtn(ontap: (){
                                    getShopKeeperAppointmentDetail(getAppoiStatusByIndex(sktabController.index));
                                  }),


                                ],
                              ),
                              TabBar(
                                controller: sktabController,
                                indicatorPadding: EdgeInsets.only(top: 45),
                                isScrollable: false,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0,),
                                  color: ColorUtil.primaryColor,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorWeight: 6,
                                labelColor: ColorUtil.primaryColor,
                                unselectedLabelColor:ColorUtil.primaryTextColor1,
                                unselectedLabelStyle: TextStyle(fontSize: 15,fontFamily: 'RM'),
                                labelStyle: TextStyle(fontSize: 15,fontFamily: 'RM'),
                                tabs: [
                                  Tab(text:"Upcoming"),
                                  Tab(text:"Completed"),
                                  Tab(text:"Cancelled"),
                                ],

                              )
                            ],
                          ),
                        ),
                        // SizedBox(height:20,),
                        Align(
                          alignment: Alignment.center,
                          child: InnerShadowTBContainer(
                            height: SizeConfig.screenHeight!-154,
                            width:width*0.95,
                            child: Obx(() =>upcomingSKAppoList.isEmpty?NoData(): ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: upcomingSKAppoList.length,
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
                                                Text('${DateFormat('dd \n MMM').format(DateTime.parse(upcomingSKAppoList[i]['AppointmentDate']))} ',
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
                                                Text('#${upcomingSKAppoList[i]['AppointmentNumber']}',
                                                  style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                                SizedBox(height: 5,),
                                                Flexible(child: Text('${upcomingSKAppoList[i]['ClientOutletName']}',
                                                  style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),)),
                                                SizedBox(height: 5,),
                                                Flexible(child: Text('${upcomingSKAppoList[i]['CustomerName']??""}',style: ColorUtil.primaryText,),),
                                                SizedBox(height: 5,),
                                                Flexible(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text('${upcomingSKAppoList[i]['TimingFixed']} ',
                                                      style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: upcomingSKAppoList[i]['AppointmentStatusId']==2,
                                            child: Container(
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  AcceptRejectBtn(title: "Accept", ontap: (){
                                                    acceptRejectParms[0].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptRejectParms[1].Value=true;
                                                    acceptRejectParms[2].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptRejectParms[3].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptAppointment();
                                                   /* createRoomFromApi(upcomingSKAppoList[i]['RoomName']).then((value){
                                                      print(value);
                                                      if(value!=null){
                                                        acceptRejectParms[0].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                        acceptRejectParms[1].Value=true;
                                                        acceptRejectParms[2].Value=value['id'];
                                                        acceptRejectParms[3].Value=value['customer_id'];
                                                        acceptAppointment();
                                                      }
                                                      else{
                                                        CustomAlert().commonErrorAlert("Error On Creating Room...", "");
                                                      }
                                                    });*/
                                                  }),
                                                  SizedBox(height: 10,),
                                                  AcceptRejectBtn(title: "Reject", ontap: (){
                                                    acceptRejectParms[0].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptRejectParms[1].Value=false;
                                                    acceptRejectParms[2].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptRejectParms[3].Value=upcomingSKAppoList[i]['AppointmentId'];
                                                    acceptAppointment();
                                                  }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: upcomingSKAppoList[i]['AppointmentStatusId']==1,
                                            child: CallBtn(ontap: () async{
                                              setSharedPrefString(upcomingSKAppoList[i]['AppointmentId'], SP_CURRENTCALLAPPOINTMENTID);
                                              setSharedPrefString(upcomingSKAppoList[i]['ClientOutletId'], SP_CURRENTCALLCLIENTOUTLETID);
                                              skCartController.getProductDrp();
                                              updateCallStatus(6);
                                              initiateCall(upcomingSKAppoList[i]['CallUserId'],upcomingSKAppoList[i]['RoomUniqueId'],await getSharedPrefString(SP_USERNAME),upcomingSKAppoList[i]['RoomName']);
                                            }),
                                          ),
                                          Visibility(
                                            visible: upcomingSKAppoList[i]['AppointmentStatusId']!=1 && upcomingSKAppoList[i]['AppointmentStatusId']!=2,
                                            child: Expanded(
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                child:  Text('${upcomingSKAppoList[i]['AppointmentStatusName']}',
                                                  style: TextStyle(fontFamily: 'RM',fontSize: 14,color:tn.primaryColor,letterSpacing: 0.1),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                Obx(() => Loader(value: showLoader.value,))
              ],
            )
        )
    );
  }

}


