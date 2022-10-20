
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
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';



class AppointmentDetails extends StatefulWidget {
  VoidCallback voidCallback;
  AppointmentDetails({required this.voidCallback});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
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
                            Text('Appointment',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  // method to show the search bar
                                  showSearch(
                                      context: context,
                                      // delegate to customize the search bar
                                      delegate: CustomSearchDelegate()
                                  );
                                },
                                child: Icon(Icons.search_sharp,color:Colors.black,size: 30,)
                            ),
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