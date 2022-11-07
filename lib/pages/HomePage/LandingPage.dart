import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../notifier/customer/appointmentNotifier.dart';
import '../../notifier/customer/homePageNotifier.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/DatePicker/date_picker_widget.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/fittedText.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/loader.dart';
import '../../widgets/validationErrorText.dart';
import '../../widgets/widgetUtils.dart';
import '../customer/navHomeScreen.dart';


class HomePage extends StatefulWidget {
  VoidCallback voidCallback;
  VoidCallback changePage;
  HomePage({required this.voidCallback,required this.changePage});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RxList<dynamic> timeSlot=RxList<dynamic>();
  RxList<dynamic> availableTimeSlot=RxList<dynamic>();
  var selectedTimeSlot=(-1).obs;
  var selectedAvailableTimeSlot=(-1).obs;
  DateTime? appoDate;

  late  double width,height,width2,height2,gridWidth;
  int selectTopSale=0;
  bool isGridView=true;
  int selectAddRemove=-1;

  String page="Appointments";
  void getTimeSlot(){
    clearAppoinFrm();
    getMasterDrp(page,"TimeSlotId",homePageController.filterShopList[homePageController.selectedShopIndex.value]['ClientId'],null).then((value){
      timeSlot.value=value;
    });
  }


  void onTimeSlotClick(val){
    print(val);
    selectedAvailableTimeSlot.value=-1;
    availableTimeSlot.clear();
    getMasterDrp(page,"AvailableTimeSlot",val['Id'],homePageController.filterShopList[homePageController.selectedShopIndex.value]['ClientId']).then((value){
      availableTimeSlot.value=value;
    });
  }

  void clearAppoinFrm({clearAll=false}){
    selectedTimeSlot.value=-1;
    selectedAvailableTimeSlot.value=-1;
    availableTimeSlot.clear();
    if(clearAll){
      timeSlot.clear();
      appoDate=DateTime.now();
      for(int i=0;i<requiredList.length;i++){
        requiredList[i]['hasError']=false;
      }
    }
  }

  RxList<dynamic> requiredList=RxList([
    {"value":"","hasError":false,"dataName":"ClientOutletId"},
    {"value":"","hasError":false,"dataName":"AppointmentDate"},
    {"value":"","hasError":false,"dataName":"TimeSlotId"},
    {"value":"","hasError":false,"dataName":"ClientTimeSlotMappingId"}]);
  void validateFrm(){
    for(int i=0;i<requiredList.length;i++){
      requiredList[i]['hasError']=false;
    }
    requiredList[0]['value']=homePageController.filterShopList[homePageController.selectedShopIndex.value]['ClientId'];
    /*if(search2.getValue()==null){
      requiredList[0]['hasError']=true;
    }
    else{
      requiredList[0]['value']=search2.getValue();
    }*/
    if(appoDate==null){
      requiredList[1]['hasError']=true;
    }
    else{
      requiredList[1]['value']=DateFormat(dbDateFormat).format(appoDate!);
    }
    if(selectedTimeSlot.value==-1){
      requiredList[2]['hasError']=true;
    }
    else{
      requiredList[2]['value']=timeSlot[selectedTimeSlot.value]['Id'];
    }
    if(selectedAvailableTimeSlot.value==-1){
      requiredList[3]['hasError']=true;
    }
    else{
      requiredList[3]['value']=availableTimeSlot[selectedAvailableTimeSlot.value]['ClientTimeSlotMappingId'];
    }
    if(!requiredList.any((element) => element['hasError']==true)){
      insertCustomerAppointmentDetail(requiredList.value,fromLandingPage: true);
    }
  }

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homePageController.getHomePageDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    gridWidth=width-30;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Consumer<ThemeNotifier>(
          builder:(ctx,tn,child)=> Stack(
            children: [
              Scaffold(
                // backgroundColor: Color(0xffF7F7FF),
                resizeToAvoidBottomInset: false,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                      height: 150,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      //   color: tn.primaryColor
                      // ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(right: 10.0,left: 10.0),
                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(onTap: (){
                                  widget.voidCallback();
                                //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                                },
                                child: Image.asset('assets/images/loginpages/menu-icon.png',height: 45,),
                               //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                ),
                                Container(
                                    // padding: EdgeInsets.only(right: 15.0),
                                    child:   Column(
                                      children: [
                                        Obx(() =>  Text("Hello ${username.value}"
                                          ,style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.black45,fontWeight: FontWeight.bold),))
                                      ],
                                    )
                                ),
                             SizedBox(width: 10,),
                                Container(
                                  // padding: EdgeInsets.only(right: 15.0),
                                  child:   Row(
                                    children: [
                                     // Text('call',style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
                                      GestureDetector(
                                          onTap:(){
                                            widget.changePage();
                                            //showPreview(true,"Muthu",'https://zoomnshop.app.100ms.live/meeting/Classroom');
                                          //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomePageVideoCall()));
                                          },
                                        child: Container(
                                          // padding: const EdgeInsets.only(right: 8.0),
                                          child: Image.asset('assets/images/loginpages/camera.png',height: 45,),
                                        ),
                                      ),
                                    ],
                                  )
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:width*0.8,
                                    height: 45,
                                    child: CompanySettingsTextField(
                                      enable: true,
                                        hintText: "Search Product", img: "assets/images/loginpages/search.png")
                                ),
                                /*GestureDetector(
                                  onTap:(){
                                    testBtmSheet();
                                  },
                                  child: Container(
                                    width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: tn.primaryColor,
                                      ) ,
                                      child:   Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/icons/Filter.png',width: 20,),
                                        ],
                                      )
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      InnerShadowTBContainer(
                        height: height-190,
                        width: width,
                        child: ListView(

                          children: [
                            SizedBox(height: 10,),
                            HPHeader(title: "Industry",),
                            Container(
                                width: SizeConfig.screenWidth,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Obx(() => ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homePageController.industryList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,i){
                                    return  GestureDetector(
                                      onTap: (){
                                          homePageController.selectedIndustryIndex.value=i;
                                          homePageController.filterShop();
                                      },
                                      child: Obx(() => AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                        decoration:i==homePageController.selectedIndustryIndex.value? BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          color:tn.primaryColor,
                                        ):BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          // border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                          color:Color(0xffDCDDE2),
                                        ) ,
                                        margin: EdgeInsets.only(right: 10,top: 5,bottom: 5,left: i==0?10:0),
                                        //width: SizeConfig.screenWidth!*0.30,
                                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        height:35 ,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Icon(Icons.dashboard_outlined,color:i==selectTopSale? Colors.white:Color(0xff959595),),
                                            Text('${homePageController.industryList[i]['IndustryCategoryName']}',
                                                style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==homePageController.selectedIndustryIndex.value? Colors.white:Color(0xff959595))
                                            ),
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                ))
                            ),
                            SizedBox(height: 10,),

                            HPHeader(title: "Shop",),
                            Container(
                                width: SizeConfig.screenWidth,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Obx(() => ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homePageController.filterShopList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,i){
                                    return  GestureDetector(
                                      onTap: (){
                                        homePageController.selectedShopIndex.value=i;
                                        homePageController.filterCategory();
                                      },
                                      child: Obx(() => AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                        decoration:i==homePageController.selectedShopIndex.value? BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          color:tn.primaryColor,
                                        ):BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          // border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                          color:Color(0xffDCDDE2),
                                        ) ,
                                        margin: EdgeInsets.only(right: 10,top: 5,bottom: 5,left: i==0?10:0),
                                        //width: SizeConfig.screenWidth!*0.30,
                                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        height:35 ,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Icon(Icons.dashboard_outlined,color:i==selectTopSale? Colors.white:Color(0xff959595),),
                                            Text('${homePageController.filterShopList[i]['ClientName']}',
                                                style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==homePageController.selectedShopIndex.value? Colors.white:Color(0xff959595))
                                            ),
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                ))
                            ),
                            SizedBox(height: 10,),

                            HPHeader(title: "Category",),
                            Container(
                                width: SizeConfig.screenWidth,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                child: Obx(() => ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homePageController.filterCategoryList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,i){
                                    return  GestureDetector(
                                      onTap: (){
                                        homePageController.selectedCategoryIndex.value=i;
                                        homePageController.filterProduct();
                                      },
                                      child: Obx(() => AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                        decoration:i==homePageController.selectedCategoryIndex.value? BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          color:tn.primaryColor,
                                        ):BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          // border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                          color:Color(0xffDCDDE2),
                                        ) ,
                                        margin: EdgeInsets.only(right: 10,top: 5,bottom: 5,left: i==0?10:0),
                                        //width: SizeConfig.screenWidth!*0.30,
                                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        height:35 ,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Icon(Icons.dashboard_outlined,color:i==selectTopSale? Colors.white:Color(0xff959595),),
                                            Text('${homePageController.filterCategoryList[i]['ProductCategoryName']}',
                                                style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==homePageController.selectedCategoryIndex.value? Colors.white:Color(0xff959595))
                                            ),
                                          ],
                                        ),
                                      )),
                                    );
                                  },
                                ))
                            ),
                            SizedBox(height: 10,),

                            /*Container(
                              margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                color: Color(0XFFF7F7FF),
                                child:  CarouselSlider(
                                  options: CarouselOptions(
                                    // aspectRatio: 16/9,
                                    height: 180,
                                    viewportFraction: 1,
                                    // initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                    // enlargeCenterPage: false,
                                  ),
                                  items: list
                                      .map((item) => Container(
                                    child: Stack(

                                      children: [
                                        Image.asset('assets/images/landingPage/slice-01.png',fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                                        Positioned(
                                          right: 30, top: 20,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20,top: 30),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:SizeConfig.screenWidth!*0.4,
                                                    child: Text('Big Sale',style: TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xffffffff),fontWeight: FontWeight.bold),)
                                                ),
                                                SizedBox(height: 10,),
                                                Container(
                                                    width:SizeConfig.screenWidth!*0.4,
                                                    child: Text('Get the trendy fashion at a discount of upto 50%',style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Colors.white60),)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                      .toList(),
                                )
                            ),*/
                           // SizedBox(height: 10,),

                            ///SizedBox(height: 10,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth,
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Top Sale',style: TextStyle(fontFamily:'RB',fontSize: 18,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                                     /* Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: GestureDetector(
                                                onTap:(){
                                                 // testBtmSheet1();
                                                },
                                                child: Text('View All',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),)),
                                          ),
                                          Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.
                                                  circular(5.0),
                                                  //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                                  color:tn.primaryColor
                                              ) ,
                                              child:   Icon(Icons.chevron_right,color: Color(0xffffffff),size: 15,)
                                          ),
                                        ],
                                      ),*/
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  child: SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    child: Obx(() => Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: homePageController.filterProductList.asMap().map((key, value) => MapEntry(key, GestureDetector(
                                        onTap:(){
                                         // log("${homePageController.filterProductList[key]}");
                                          appointmentSheet();
                                        },
                                        child: Container(
                                          height: 300,
                                          ///  width: width*0.48,
                                          //   margin: EdgeInsets.fromLTRB(width*0.01, 5, width*0.01, 5),
                                          width: gridWidth*0.5,
                                          //margin: EdgeInsets.fromLTRB(10, 5, width*0.01, 5),
                                          // clipBehavior: Clip.antiAlias,
                                          // decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(20),
                                          //     color: lightGrey
                                          // ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 255,
                                                width: gridWidth*0.9,
                                                //child: Image.asset("assets/images/landingPage/slice-02.jpg"),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) => Container(),
                                                  imageUrl: GetImageBaseUrl()+homePageController.filterProductList[key]['ProductImage'],
                                                  errorWidget:(c,a,b)=> Image.asset("assets/images/landingPage/slice-02.jpg"),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: 7),
                                                      width: (gridWidth*0.5)-40,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            child: Text('${homePageController.filterProductList[key]['ProductName']}',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 13),),
                                                          ),
                                                          /*Container(
                                                            child: Text('129.00',style: TextStyle(fontFamily: 'RR',color: Colors.black26,fontSize: 12),),
                                                          ),*/
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:Color(0xFF000000).withOpacity(0.15),
                                                            blurRadius: 10.0, // soften the shadow
                                                            spreadRadius: 0.1, //extend the shadow
                                                            offset: Offset(
                                                              4.0, // Move to right 10  horizontally
                                                              4.0, // Move to bottom 10 Vertically
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      child: Icon(Icons.favorite,color: tn.primaryColor.withOpacity(0.8),size: 18,),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))).values.toList(),
                                    )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               // bottomNavigationBar: BottomNavi(),
              ),
              /*Positioned(
                bottom: -15,
                  child: BottomNavi()
              )*/
              Obx(() => Loader(value: showLoader.value,))
            ],
          ),
        ),
    );
  }

  void appointmentSheet() {
    getTimeSlot();
    clearAppoinFrm(clearAll: true);
    Get.bottomSheet(
        Container(
            height: SizeConfig.screenHeight!*0.8,
            padding: EdgeInsets.only(left: 15,right: 15),
            color: ColorUtil.secondaryBg,
            child:Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    /*Text('Select Shop',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                    SizedBox(height: 5,),*/
                    Obx(() => Visibility(
                        visible: requiredList[0]['hasError'],
                        child: ValidationErrorText())),
                    SizedBox(height: 20,),
                    Text('PICK DATE',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                    Container(
                        height: 100,
                        child: DatePicker(
                          DateTime.now(),
                          width: 55,
                          height: 80,
                          // controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.transparent,
                          selectedTextColor: ColorUtil.primaryColor,
                          dateTextStyle: ts18(ColorUtil.black,fontfamily: 'RM'),
                          dayTextStyle: ts15(ColorUtil.black,fontfamily: 'RR'),
                          onDateChange: (date) {
                            // New date selected
                            setState(() {
                              appoDate = date;
                            });
                          },
                          needMonth: true,
                        )
                    ),
                    Obx(() => Visibility(
                        visible: requiredList[1]['hasError'],
                        child: ValidationErrorText())),
                    Text('TIME SLOT',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                    SizedBox(height: 10,),
                    Obx(() => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: timeSlot.asMap().map((key, value) => MapEntry(key, GestureDetector(
                        onTap: (){
                          selectedTimeSlot.value=key;
                          onTimeSlotClick(value);
                        },
                        child: Container(
                          width: gridWidth*0.48,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: SizeConfig.screenWidth,
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:selectedTimeSlot.value==key?ColorUtil.primaryColor: Color(0xffECEBF9)
                                ),
                                child: FittedText(
                                  height: 15,
                                  width: gridWidth*0.48,
                                  alignment: Alignment.center,
                                  text: '${value['Text']}',
                                  textStyle: ts15(selectedTimeSlot.value==key?Colors.white:ColorUtil.black,fontfamily: 'RM'),
                                ),
                                //child:Text('${value['Text']}',style: TextStyle(fontFamily: 'RM',fontSize: 16,color:Color(0XFF000000)),),
                              )
                            ],
                          ),
                        ),
                      ))).values.toList(),
                    )),
                    Obx(() => Visibility(
                        visible: requiredList[2]['hasError'],
                        child: ValidationErrorText())),
                    SizedBox(height: 20,),
                    Text('AVAILABLE  TIME',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                    SizedBox(height: 10,),
                    Flexible(
                      child: SingleChildScrollView(
                        child:   Obx(() => Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: availableTimeSlot.asMap().map((key, value) => MapEntry(key, GestureDetector(
                            onTap: (){
                              selectedAvailableTimeSlot.value=key;
                            },
                            child: Container(
                              width: gridWidth*0.48,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: SizeConfig.screenWidth,
                                    decoration:BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:selectedAvailableTimeSlot.value==key?ColorUtil.primaryColor: Color(0xffECEBF9)
                                    ),
                                    child: FittedText(
                                      height: 15,
                                      width: gridWidth*0.48,
                                      alignment: Alignment.center,
                                      text: '${value['FromTime']} - ${value['ToTime']}',
                                      textStyle: ts15(selectedAvailableTimeSlot.value==key?Colors.white:ColorUtil.black,fontfamily: 'RM'),
                                    ),
                                    //child:Text('${value['Text']}',style: TextStyle(fontFamily: 'RM',fontSize: 16,color:Color(0XFF000000)),),
                                  )
                                ],
                              ),
                            ),
                          ))).values.toList(),
                        )),
                      ),
                    ),
                    Obx(() => Visibility(
                        visible: requiredList[3]['hasError'],
                        child: ValidationErrorText())),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        validateFrm();
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffFE316C),
                              shape: BoxShape.circle
                          ),
                          child: Icon(Icons.arrow_forward_outlined,color:Color(0xffffffff),size: 30,),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
                Obx(() => Container(
                    height: SizeConfig.screenHeight!*0.8,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Loader(value: showLoader.value,)))
              ],
            )
        ),
        //barrierColor: Colors.red[50],
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),),
        enableDrag: false,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias
    );
  }

  void testBtmSheet1() {
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
              Text('05:00 Min',style: TextStyle(fontFamily: 'RM',fontSize: 20,color:Color(0XFFFE316C)),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: SizeConfig.screenWidth!*0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0XFFFE316C),
                  ),
                  alignment: Alignment.center,
                  child: Text("Accept",style: whiteRM20,),
                ),
              ),
              SizedBox(height: 10,),
              Text('Postpone',style: TextStyle(fontFamily: 'RM',fontSize: 20,color:Color(0XFF8E8E8E)),),
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



  addRemoveBtn(Widget icon){
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(5)
      ),
      child: Center(
        child: icon,
      ),
    );
  }

}


