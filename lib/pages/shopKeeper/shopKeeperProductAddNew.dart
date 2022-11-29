import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/app_theme.dart';
import 'package:zoomnshop/notifier/shopKeeper/skProductNotifier.dart';
import 'package:zoomnshop/styles/style.dart';

import '../../HappyExtension/utilWidgets.dart';
import '../../styles/constants.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/searchDropdown/search2.dart';

class ProductAddNew extends StatefulWidget {
  const ProductAddNew({Key? key}) : super(key: key);

  @override
  State<ProductAddNew> createState() => _ProductAddNewState();
}

class _ProductAddNewState extends State<ProductAddNew> {
  var node;
  AddNewLabelTextField addNewLabelTextField= AddNewLabelTextField(
      labelText: 'Product Name',
      dataname: "ProductName",
      onChange: (v){},
      onEditComplete: (){},
      ontap: (){},
      required: true,
  );
  AddNewLabelTextField addNewLabelTextField2= AddNewLabelTextField(
    labelText: 'Product Price',
    dataname: "Price",
    onChange: (v){},
    onEditComplete: (){},
    ontap: (){},
    textInputType: TextInputType.numberWithOptions(),
    regExp: decimalReg,
  );
  AddNewLabelTextField addNewLabelTextField3= AddNewLabelTextField(
      labelText: 'Description',
      dataname: "Description",
      onChange: (v){},
      onEditComplete: (){},
      ontap: (){}
  );
  Search2 categoryDrp=Search2(
    dataName: "ProductCategoryId",
    width: 400,
    dialogWidth: 360,
    selectWidgetHeight: 50,
    hinttext: "Select Category",
    data: [],
    propertyId: "Id",
    propertyName: "Text",
    showSearch: false,
    onitemTap: (i){},
    selectedValueFunc: (e){},
    scrollTap: (){},
    isToJson: true,
    margin: EdgeInsets.only(left: 20,right: 20,top: 15),
    dialogMargin: EdgeInsets.only(left: 20,right: 20,top: 5),
    required: true,
  );
  @override
  void initState(){
    addNewLabelTextField.onEditComplete=(){node.unfocus();};
    addNewLabelTextField2.onEditComplete=(){node.unfocus();};
    addNewLabelTextField3.onEditComplete=(){node.unfocus();};
    assign();
    super.initState();
  }

  void assign(){
    skProductController.addNewWidgets.clear();
    skProductController.addNewWidgets.add(addNewLabelTextField);
    skProductController.addNewWidgets.add(categoryDrp);
    skProductController.addNewWidgets.add(addNewLabelTextField2);
    skProductController.addNewWidgets.add(addNewLabelTextField3);
    setState((){ });
    skProductController.fillOI_Drp();
  }

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              height: 50,
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 25,),
                    decoration: BoxDecoration(
                        color: ColorUtil.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtil.primaryColor.withOpacity(0.9),
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
                      //cartController.cartProductList.clear();
                    }, icon: Icon(Icons.arrow_back_ios_sharp,color:Colors.white,size: 20,),),
                  ),
                  SizedBox(width: 30,),
                  Text("Product Detail / Add New",style: ts16(ColorUtil.primaryTextColor1),)
                ],
              ),
            ),


            for(int i=0;i<skProductController.addNewWidgets.length;i++)
              skProductController.addNewWidgets[i],

            GestureDetector(
              onTap: (){
                skProductController.onOpenItemSave();
              },
              child: Container(
                height: 60,
                width: SizeConfig.screenWidth!*0.85,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0XFFFE316C),
                ),
                alignment: Alignment.center,
                child: Text("Add Product",style: whiteRM20,),
              ),
            ),
          ],
        ),
      )
    );
  }
}
