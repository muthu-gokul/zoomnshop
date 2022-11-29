import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../HappyExtension/extension.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../configuration.dart';
var skProductController=Get.put(SkProductNotifier());
class SkProductNotifier extends GetxController{

  var gridData=[].obs;
  var filterGridData=[].obs;

  void getProductDetail() async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getProductDetail));
    params.add(ParameterModel(Key: "ClientId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
    params.add(ParameterModel(Key: "ProductId", Type: "String", Value: null));
    log(json.encode(params));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
        gridData.value=parsed['Table'] as List;
        filterGridData.value=gridData.value;
      }
    });
  }



  List<dynamic> addNewWidgets=[];

  void fillOI_Drp() async{
    getMasterDrp("Product", "ProductCategoryId", await getSharedPrefString(SP_COMPANYID), null).then((value){
      log("$value");
      addNewWidgets[1].setDataArray(value);
    });

  }

  void onOpenItemSave() async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertProductDetail));
    params.addAll(await getFrmCollectionV2(addNewWidgets));
    log("${jsonEncode(params)}");
    return;

    ApiManager().GetInvoke(params).then((value){
      if(value[0]){
        var response=json.decode(value[1]);
        print("onOpenItemSave $response");
      }
    });
  }
}