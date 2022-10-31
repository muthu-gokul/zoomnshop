
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/notifier/customer/appointmentNotifier.dart';
import 'package:zoomnshop/pages/navHomeScreen.dart';
import 'package:zoomnshop/widgets/searchDropdown/search2.dart';
import '../../api/apiUtils.dart';
import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/closeButton.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';



class AppointmentDetails extends StatefulWidget {
  VoidCallback voidCallback;
  AppointmentDetails({required this.voidCallback});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {

  RxList<dynamic> timeSlot=RxList<dynamic>();
  var selectedTimeSlot=(-1).obs;

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
      border: Border.all(color: Colors.red),
      color: Colors.grey.withOpacity(0.2)
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
    getCustomerAppointmentDetail();
    getDrp();
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
      selectedTimeSlot.value=-1;
      getMasterDrp(page,"TimeSlotId",s['Id'],null).then((value){
        print(value);
        timeSlot.value=value;
      });
    };
  }

  void onTimeSlotClick(val){
    print(val);
    getMasterDrp(page,"AvailableTimeSlot",val['Id'],search2.getValue()).then((value){
      print("AvailableTimeSlot");
      print(value);
    });
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
                            Text('Appointment',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                            Spacer(),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  Text('09 ',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: Color(0xffC00135),),),
                                                  Text('Sep ',style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xffC00135),),),
                                                ],
                                              ),
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
                                              child:  Text('11.30 AM',style: TextStyle(fontFamily: 'RM',fontSize: 14,color:tn.primaryColor,letterSpacing: 0.1),),
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
            Positioned(
                bottom: -15,
                child: BottomNavi()
            )
          ],

        )
        )
    );
  }
  List<int> TimeSlot=List.generate(4, (index) => index);
  List<int> AvailaTime=List.generate(2, (index) => index);
  void testBtmSheetSlot() {
    Get.bottomSheet(
        Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            color: Colors.white,
            child:Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Select Shop',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                search2,
                SizedBox(height: 20,),
                Text('PICK DATE',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                Container(
                    height: 100,
                    child: Image.asset('assets/images/loginpages/resetpassword.png')),
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
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: SizeConfig.screenWidth,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffECEBF9)
                            ),
                            child:Text('${value['Text']}',style: TextStyle(fontFamily: 'RM',fontSize: 16,color:Color(0XFF000000)),),
                          )
                        ],
                      ),
                    ),
                  ))).values.toList(),
                )),
                SizedBox(height: 20,),
                Text('AVAILABLE  TIME',style: TextStyle(fontFamily: 'RM',fontSize: 18,color:Color(0XFF000000)),),
                SizedBox(height: 10,),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: AvailaTime.asMap().map((key, value) => MapEntry(key, Container(
                    // height: 100,
                    ///  width: width*0.48,
                    //   margin: EdgeInsets.fromLTRB(width*0.01, 5, width*0.01, 5),
                    width: gridWidth*0.48,
                    //margin: EdgeInsets.fromLTRB(10, 5, width*0.01, 5),
                    // clipBehavior: Clip.antiAlias,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: lightGrey
                    // ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: SizeConfig.screenWidth,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffECEBF9)
                          ),
                          child:Text('30 MIN',style: TextStyle(fontFamily: 'RM',fontSize: 16,color:Color(0XFF000000)),),
                        )
                      ],
                    ),
                  ))).values.toList(),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.back();
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
              ],
            )
        ),
        //barrierColor: Colors.red[50],
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        enableDrag: false,
        isScrollControlled: true
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