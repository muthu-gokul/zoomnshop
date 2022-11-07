import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/styles/style.dart';
import 'package:zoomnshop/utils/colorUtil.dart';
import 'package:zoomnshop/videoCall/service/room_service.dart';
import 'package:zoomnshop/widgets/closeButton.dart';
import 'package:zoomnshop/widgets/fittedText.dart';
import 'package:zoomnshop/widgets/searchDropdown/dropdown_search.dart';
import 'package:zoomnshop/widgets/widgetUtils.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/searchDropdown/search2.dart';
import '../../widgets/validationErrorText.dart';
import '../configuration.dart';
var skCartController=Get.put(SkCartNotifier());
class SkCartNotifier extends GetxController{
  Search2 search2 = Search2(
    dialogWidth: SizeConfig.screenWidth!,
    dataName: '',
    selectWidgetHeight: 50,
    selectWidgetBoxDecoration: BoxDecoration(
        color: ColorUtil.ternaryBg,
        borderRadius: BorderRadius.circular(10)
    ),
    margin: EdgeInsets.all(0),
    dialogMargin: EdgeInsets.fromLTRB(0,0,0,0),
    hinttext: "Select Product",
    data: [],
    onitemTap: (i){},
    selectedValueFunc: (s){

    },
    scrollTap: (){},
    showSearch: true,
    isToJson: true,
    isEnable: true,
    mode: Mode.DIALOG,
    maxHeight: 500,
  );
  var quantity=1.obs;
  var isInValidProduct=false.obs;
  void getProductDrp() async{
    getMasterDrp("Appointments", "ProductId", await getSharedPrefString(SP_COMPANYID), null).then((value){
      search2.setDataArray(value);
    });
  }

  void insertCart() async{
    if(search2.getValue()==null || search2.getValue()==''){
      isInValidProduct.value=true;
    }
    else{
      isInValidProduct.value=false;
    }
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertCart));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: await getSharedPrefString(SP_CURRENTCALLAPPOINTMENTID)));
    params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
    params.add(ParameterModel(Key: "ProductId", Type: "String", Value: search2.getValue()));
    params.add(ParameterModel(Key: "Quantity", Type: "String", Value: quantity.value));

    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        Get.back();
        showVideo.value=true;
      }
    });
  }


  RxList<dynamic> skCartAppList=RxList<dynamic>();

  void getCartApp() async{

    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getAppCart));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: null));
   // params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        skCartAppList.value=parsed['Table'];
        log("$parsed");
      }
    });
  }
  void getCartDetail(appId) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getAppCart));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: appId));
   // params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: clientId));
    print(jsonEncode(params));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
      }
    });
  }


}

void showProductAddPopUp(){
  showVideo.value=false;
  skCartController.search2.clearValues();
  skCartController.quantity.value=1;
  showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        contentPadding:EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
        clipBehavior: Clip.antiAlias,
        content: Container(
          /* height:280,*/
            width:SizeConfig.screenWidth!*0.9,
            decoration:BoxDecoration(
              color:Colors.white,
            ),
            padding: EdgeInsets.all(15),
            child:Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  skCartController.search2,
                  Obx(() => Visibility(visible: skCartController.isInValidProduct.value,child: ValidationErrorText())),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CloseBtn(
                        height: 50,
                        bgClr: Colors.red,
                        icon: Icons.remove,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red
                        ),
                        onTap: (){
                          if(skCartController.quantity.value>1){
                            skCartController.quantity.value--;
                          }
                        },
                      ),
                      Obx(() => FittedText(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        textStyle: ts18(ColorUtil.black,fontfamily: 'RM',fontsize: 30),
                        text: '${skCartController.quantity.value}',
                      )),
                      CloseBtn(
                        height: 50,
                        bgClr: Colors.green,
                        icon: Icons.add,
                        boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green
                        ),
                        onTap: (){
                          skCartController.quantity.value++;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  DoneBtn(onDone: (){
                    skCartController.insertCart();
                  }, title: "Done"),
                ]
            )
        ),
      )
  ).then((value) {
    showVideo.value=true;
  });
}