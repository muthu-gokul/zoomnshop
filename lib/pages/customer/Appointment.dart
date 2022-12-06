
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/utils/utilsWidgets.dart';
import 'package:zoomnshop/widgets/noDataFound.dart';
import '../../api/ApiManager.dart';
import '../../notifier/callNotifier.dart';
import '../../notifier/configuration.dart';
import '../../notifier/customer/appointmentNotifier.dart';
import '../../utils/colorUtil.dart';
import '../../widgets/fittedText.dart';
import '../../widgets/loader.dart';
import '../../widgets/searchDropdown/search2.dart';
import '../../api/apiUtils.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/DatePicker/date_picker_widget.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/closeButton.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/validationErrorText.dart';



class AppointmentDetails extends StatefulWidget {
  VoidCallback voidCallback;
  AppointmentDetails({required this.voidCallback});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}
class _AppointmentDetailsState extends State<AppointmentDetails> with TickerProviderStateMixin{

  RxList<dynamic> timeSlot=RxList<dynamic>();
  RxList<dynamic> availableTimeSlot=RxList<dynamic>();
  var selectedTimeSlot=(-1).obs;
  var selectedAvailableTimeSlot=(-1).obs;
  DateTime? appoDate;

  late  double width,height,width2,height2,gridWidth;
  bool openText=false;



  close(){
    Timer(animeDuration, (){
      setState(() {
        openText=false;
      });
    });
  }

  Search2 search2 = Search2(
      dialogWidth: SizeConfig.screenWidth!,
      dataName: '',
      selectWidgetHeight: 50,
    selectWidgetBoxDecoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    margin: EdgeInsets.all(0),
    dialogMargin: EdgeInsets.fromLTRB(20,0,20,0),
    hinttext: "Select Shop",
    data: [],
    onitemTap: (i){},
    selectedValueFunc: (s){

    },
    scrollTap: (){},
    showSearch: false,
    isToJson: true,
    isEnable: true,
  );

  @override
  void initState(){
    customerAppTabController = TabController(length: 3,  vsync: this);
    customerAppTabController.addListener(() {
      if(!customerAppTabController.indexIsChanging){
        getCustomerAppointmentDetail(getAppoiStatusByIndex(customerAppTabController.index));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCustomerAppointmentDetail(getAppoiStatusByIndex(0));
      getDrp();
    });
    super.initState();
  }

  String page="Appointments";
  void getDrp(){
    getMasterDrp(page,"ClientOutletId",null,null).then((value){
      print(value);
      search2.setDataArray(value);
    });
    search2.selectedValueFunc=(s){
      print("ss $s");
      clearAppoinFrm();
      getMasterDrp(page,"TimeSlotId",s['Id'],null).then((value){
        print(value);
        timeSlot.value=value;
      });
    };
  }

  void onTimeSlotClick(val){
    print(val);
    selectedAvailableTimeSlot.value=-1;
    availableTimeSlot.clear();
    getMasterDrp(page,"AvailableTimeSlot",val['Id'],search2.getValue()).then((value){
      print("AvailableTimeSlot");
      print(value);
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
    print(search2.getValue());
    for(int i=0;i<requiredList.length;i++){
      requiredList[i]['hasError']=false;
    }
    if(search2.getValue()==null){
      requiredList[0]['hasError']=true;
    }
    else{
      requiredList[0]['value']=search2.getValue();
    }
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
      print(requiredList);
      insertCustomerAppointmentDetail(requiredList.value);
    }
  }



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
                                getCustomerAppointmentDetail(getAppoiStatusByIndex(customerAppTabController.index));
                              }),
                              CloseBtn(
                               icon: Icons.add,
                               onTap: (){
                                 testBtmSheetSlot();
                               },
                              ),
                              /*GestureDetector(
                                  onTap: () {
                                    // method to show the search bar
                                    showSearch(
                                        context: context,
                                        // delegate to customize the search bar
                                        delegate: CustomSearchDelegate()
                                    );
                                  },
                                  child: Icon(Icons.search_sharp,color:Colors.black,size: 30,)
                              ),*/
                            ],
                          ),
                          TabBar(
                            controller: customerAppTabController,
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
                        child: Obx(() =>upcomingCustomerApplist.isEmpty?NoData(): ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: upcomingCustomerApplist.length,
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
                                            Text('${DateFormat('dd \n MMM').format(DateTime.parse(upcomingCustomerApplist[i]['AppointmentDate']))} ',
                                              style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xffC00135)),textAlign: TextAlign.center,),
                                           // Text('Sep ',style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xffC00135),),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(
                                        child: Flexible(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment:MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('#${upcomingCustomerApplist[i]['AppointmentNumber']}',
                                                style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),),
                                              Flexible(child: Text('${upcomingCustomerApplist[i]['ClientOutletName']}',
                                                style: TextStyle(fontFamily: 'RB',fontSize: 14,color: Colors.black,letterSpacing: 0.1),)),
                                              SizedBox(height: 5,),
                                              Flexible(child: Text('${upcomingCustomerApplist[i]['ClientOutletAddress']??"Address: "}',style: ColorUtil.primaryText,),),
                                              SizedBox(height: 5,),
                                              Flexible(child: Text('${upcomingCustomerApplist[i]['TimingFixed']}',style: ColorUtil.primaryText,),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Visibility(
                                        visible: upcomingCustomerApplist[i]['AppointmentStatusId']!=1,
                                        child: Container(
                                         // width: 150,
                                          alignment: Alignment.centerRight,
                                          child:  Text('${upcomingCustomerApplist[i]['AppointmentStatusName']}',
                                            style: TextStyle(fontFamily: 'RM',fontSize: 14,color:tn.primaryColor,letterSpacing: 0.1),
                                          ),
                                        )
                                      ),
                                      Visibility(
                                        visible: upcomingCustomerApplist[i]['AppointmentStatusId']==1,
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: CallBtn(
                                            ontap: ()async{
                                              /*log("${upcomingCustomerApplist[i]} ${upcomingCustomerApplist[i]['RoomUniqueId']} ${upcomingCustomerApplist[i]['RoomName']}}");
                                              return;*/
                                              updateCallStatusCustomer(6,upcomingCustomerApplist[i]['AppointmentId'],upcomingCustomerApplist[i]['ClientOutletId']);
                                             initiateCall(upcomingCustomerApplist[i]['CallUserId'],upcomingCustomerApplist[i]['RoomUniqueId'],await getSharedPrefString(SP_USERNAME),upcomingCustomerApplist[i]['RoomName']);
                                            },
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
          /*  Positioned(
                bottom: -15,
                child: BottomNavi()
            ),*/
            Obx(() => Loader(value: showLoader.value,))
          ],
          )
        )
    );
  }

  void testBtmSheetSlot() {
    search2.clearValues();
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
                    Text('Select Shop',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                    SizedBox(height: 5,),
                    search2,
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

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Men",
    "Women",
    "Kids",
    "Sarees",
    "Tops",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}