import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/pages/shopKeeper/shopKeeperProductAddNew.dart';

import '../../notifier/shopKeeper/skProductNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/closeButton.dart';
import '../../widgets/fittedText.dart';
import '../../widgets/grid/gridWithWidgetParam.dart';
import '../../widgets/noDataFound.dart';

class ProductMaster extends StatefulWidget {
  VoidCallback voidCallback;
  ProductMaster({required this.voidCallback});

  @override
  State<ProductMaster> createState() => _ProductMasterState();
}

class _ProductMasterState extends State<ProductMaster> {

  @override
  void initState(){
    skProductController.getProductDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                Container(
                  height: 60,
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
                          Text('Product Detail',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),
                          Spacer(),
                          CloseBtn(
                            icon: Icons.add,
                            iconSize: 25,
                            onTap: (){
                              Get.to(ProductAddNew());
                            },
                          ),
                          RefreshBtn(ontap: (){
                             skProductController.getProductDetail();
                          }),


                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() => Stack(
                  children: [
                    GridWithWidgetParam(
                        topMargin: 0,
                        gridBodyReduceHeight: 60,
                        gridHeight: SizeConfig.screenHeight!-60,
                        leftHeader: "Product Name",
                        leftBody:  Column(
                            children: skProductController.filterGridData.asMap().map((key, value) => MapEntry(key,
                                Container(
                                  alignment:Alignment.centerLeft,
                                  padding:  EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: gridBottomborder,
                                  ),
                                  height: 50,
                                  width: 155,
                                  child: Row(
                                    children: [
                                      FittedText(
                                        height: 16,
                                        width: 115,
                                        alignment: Alignment.centerLeft,
                                        text:"${value['ProductName']}",
                                        textStyle:gridTextColor14,
                                      ),
                                    ],
                                  ),
                                )
                            )).values.toList()
                        ),
                        rightHeader: Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                width: 110,
                                child: Text("Category",
                                  style: gridHeaderTS,)
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 0),
                                width: 220,
                                child: Text("Price",
                                  style: gridHeaderTS,)
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 0),
                                width: 150,
                                child: Text("Description",
                                  style: gridHeaderTS,)
                            ),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 10),
                                width: 100,
                                child: Text("Action",
                                  style: gridHeaderTS,)
                            ),

                          ],
                        ),
                        rightBody: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: skProductController.filterGridData.asMap().map((key, value) => MapEntry(key,
                              GestureDetector(
                                onTap: (){
                                  // if(selectedIndex==key){
                                  //   selectedIndex.value=-1;
                                  //   showEdit.value=false;
                                  // }
                                  // else{
                                  //   selectedIndex.value=key;
                                  //   showEdit.value=true;
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: gridBottomborder,
                                    //   color: widget.selectedUid==value['Uid']?yellowColor:gridBodyBgColor,
                                  ),
                                  height: 50,
                                  // margin: EdgeInsets.only(bottom:i==lists.length-1?70: 0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 10),
                                            width: 110,

                                            child: Text("${value['ProductCategoryName']}",
                                              style: gridTextColor14,)
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 0),
                                            width: 220,

                                            child: Text("${value['Price']}",
                                              style: gridTextColor14,)
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 0),
                                            width: 150,

                                            child: Text("${value['Description']}",
                                              style: gridTextColor14,)
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 10),
                                            width: 100,
                                            child: GestureDetector(
                                              onTap: (){
                                                //Get.to(InvoiceTestAddNew(editId: '${value['InventoryBillingId']}',));
                                               // invoiceNotifier.getBillingView(value['InventoryBillingId']);
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                alignment: Alignment.center,
                                                color: Colors.transparent,
                                             //   child: SvgPicture.asset("assets/icons/pdfView.svg"),
                                              ),
                                            )
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                            )).values.toList()
                        )
                    ),
                    //Obx(() => NoData(hasData: skProductController.filterGridData.isEmpty))
                  ],
                )
                ),

              ],
            ),
          ),



          //bottomNav
          /*Positioned(
            bottom: 0,
            child: Container(
              width: SizeConfig.screenWidth,
              // height:_keyboardVisible?0:  70,
              height: 65,
              decoration: BoxDecoration(
                  color: Colors.white12.withOpacity(0.1),
                  // color: Color(0xFF787878).withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF787878).withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 25,
                      offset: Offset(0, 0), // changes position of shadow
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                    ),
                    margin:EdgeInsets.only(top: 0),
                    child: CustomPaint(
                      size: Size( SizeConfig.screenWidth!, 65),
                      painter: RPSCustomPainter(),
                    ),
                  ),
                  Container(
                    width:  SizeConfig.screenWidth,
                    height: 65,
                    child: Stack(
                      children: [
                        Align(
                          alignment:Alignment.centerRight,

                        ),
                        Align(
                          alignment:Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: (){

                            },

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AddButton(
                ontap: (){
                  //Get.to(InvoiceTestAddNew(editId: '',));
                  Get.to(InvoiceAddNew());
                },
                image: "assets/icons/plusIcon.svg",
                imgColor: Colors.white,
                color: Color(0xFF44904B)
            ),
          ),
          Obx(() => Loader(
            isLoad: invoiceNotifier.isLoad.value,
          ))*/
        ],
      ),
    );
  }
}
