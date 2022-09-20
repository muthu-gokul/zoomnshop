import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';

class ProductAddView extends StatefulWidget {
  VoidCallback voidCallback;
  ProductAddView({required this.voidCallback});

  @override
  _ProductAddViewState createState() => _ProductAddViewState();
}

class _ProductAddViewState extends State<ProductAddView>with TickerProviderStateMixin {
  @override
  late TabController _tabController;
  late  double width,height,width2,height2;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3,  vsync: this);
  }
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
      child:Consumer<ThemeNotifier>(
        builder:(ctx,tn,child)=> Stack(
          children: [
            Scaffold(
              // backgroundColor: Colors.white,
              body: Container(
                margin:  EdgeInsets.only(left:15.0,right: 15.0),
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                      height: 120,
                      //  clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      //       color: tn.primaryColor
                      //   ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            height: 60,
                            // margin:  EdgeInsets.only(left:15.0,right: 15.0),
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
                                Text('Products',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
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
                          Container(
                            // padding: EdgeInsets.only(left: 25,right: 25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: tn.primaryColor.withOpacity(0.7)
                            ),
                            child: TabBar(
                                controller: _tabController,
                                // give the indicator a decoration (color and border radius)
                                // indicatorPadding: EdgeInsets.only(top: 45),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0,),
                                  color:tn.primaryColor,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                // indicatorWeight: 6,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                                labelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                                tabs: [
                                  Tab(text:"Products"),
                                  Tab(text:"+Add Products"),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenHeight!-165,
                      width: SizeConfig.screenWidth!*1,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Align(
                            alignment:Alignment.topCenter,
                            child: Container(
                              width: SizeConfig.screenWidth!*1,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Container(
                                      width:width,
                                      height: 45,
                                      child: CompanySettingsTextField(
                                          enable: true,
                                          hintText: "Search Product", img: "assets/images/loginpages/search.png")
                                  ),
                                  InnerShadowTBContainer(
                                    height: SizeConfig.screenHeight!-230,
                                    width: SizeConfig.screenWidth!*1,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: 20,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (ctx,i){
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 10,top:i==0? 10:0),
                                          width: SizeConfig.screenWidth!*1,
                                          height: 80,
                                          decoration:i==0? BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Color(0XFFF5F5F5)),
                                            boxShadow: [
                                              BoxShadow(color: Colors.black26, spreadRadius: 0,blurRadius: 9,
                                                offset: Offset(
                                                  0.0, // Move to right 10  horizontally
                                                  5.0, // Move to bottom 10 Vertically),
                                                ),),
                                            ],
                                            color: Color(0XFFffffff),
                                          ): BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: Color(0XFFF5F5F5)),
                                            color: Color(0XFFffffff),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [

                                                    Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Mens Jeans',style: TextStyle(fontSize: 16,fontFamily: 'RR',color: Color(0xff808080),fontWeight: FontWeight.w600),),
                                                          SizedBox(height: 5,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text('₹ 250.00',style: TextStyle(fontSize: 14,fontFamily: 'RM',color:tn.primaryColor,),),
                                                              SizedBox(width: 5,),
                                                              Text('GST 12.00',style: TextStyle(fontSize: 10,fontFamily: 'RM',color:Color(0xffA1A1A1),),),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                  margin: EdgeInsets.only(right: 8,top: 10,bottom: 5),
                                                  height:30,
                                                  width:80,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0XFFFFEAF1),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text('Men Cloth',style: TextStyle(fontSize: 14,fontFamily: 'RR',color:tn.primaryColor,),)
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment:Alignment.topCenter,
                            child: Container(
                              width: SizeConfig.screenWidth!*1,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  CompanySettingsTextField(
                                    hintText: "Product Name",
                                    img: "",
                                    borderRadius: textFieldBR,
                                  ),
                                  SizedBox(height: 10,),
                                  CompanySettingsTextField(
                                    hintText: "Product Code",
                                    img: "",
                                    borderRadius: textFieldBR,
                                  ),
                                  SizedBox(height: 10,),
                                  CompanySettingsTextField(
                                    hintText: "Category",
                                    img: "",
                                    borderRadius: textFieldBR,
                                  ),
                                  SizedBox(height: 10,),
                                  CompanySettingsTextField(
                                    hintText: "Enter Amount",
                                    img: "",
                                    borderRadius: textFieldBR,
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                                    },
                                    child: Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth!*0.65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0XFFFE316C),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("Save",style: whiteRM20,),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: -15,
                child: BottomNavi()
            )
          ],
        ),
      ),
    );
  }
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