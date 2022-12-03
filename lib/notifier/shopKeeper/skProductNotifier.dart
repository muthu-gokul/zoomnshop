import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';

import '../../HappyExtension/extension.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../helper/helper.dart';
import '../../model/parameterMode.dart';
import '../configuration.dart';
import '../utils.dart';
var skProductController=Get.put(SkProductNotifier());
class SkProductNotifier extends GetxController{



  var customerLogoFileName;
  var customerLogoFolderName="Product";
  var customerLogoUrl="".obs;
  File? logoFile;

  var gridData=[].obs;
  var filterGridData=[].obs;

  void getProductDetail({int? productId=null}) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getProductDetail));
    params.add(ParameterModel(Key: "ClientId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
    params.add(ParameterModel(Key: "ProductId", Type: "String", Value: productId));
    //log(json.encode(params));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
        if(productId==null){
          gridData.value=parsed['Table'] as List;
          filterGridData.value=gridData.value;
        }
        else{
          setFrmValuesV2(addNewWidgets, parsed['Table']);
          logoFile=null;
          customerLogoFileName= parsed['Table'][0]['ProductImage'];
          customerLogoUrl.value=GetImageBaseUrl()+customerLogoFileName;

        }
      }
    });
  }



  List<dynamic> addNewWidgets=[];

  Future<void> fillOI_Drp() async{
    await getMasterDrp("Product", "ProductCategoryId", await getSharedPrefString(SP_COMPANYID), null).then((value){
      log("$value");
      addNewWidgets[1].setDataArray(value);
    });
  }

  void onOpenItemSave(bool isEdit) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value:isEdit?Sp.updateProductDetail: Sp.insertProductDetail));
    params.add(ParameterModel(Key: "ClientId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));

    params.addAll(await getFrmCollectionV2(addNewWidgets));
    //customerLogoFileName="";
    if(logoFile!=null){
      customerLogoFileName=await MyHelper.uploadFile(customerLogoFolderName,logoFile!);
    }
    params.add(ParameterModel(Key: "ProductFileName", Type: "String", Value: getImgFileName(customerLogoFileName)));
    params.add(ParameterModel(Key: "ProductVideoFileName", Type: "String", Value: ""));
    params.add(ParameterModel(Key: "ProductTypeId", Type: "String", Value: ""));

    ApiManager().GetInvoke(params).then((value){
      if(value[0]){
        Get.back();
        CustomAlert().successAlert("Product ${isEdit?"Updated":"Added"}...", "");
        getProductDetail();
      }
    });
  }

  void deleteProductDetail({int? productId=null}) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.deleteProductDetail));
    params.add(ParameterModel(Key: "ClientId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
    params.add(ParameterModel(Key: "ProductId", Type: "String", Value: productId));
    //log(json.encode(params));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]) {
        getProductDetail();
        CustomAlert().successAlert("Deleted Successfully...", "");
      }
    });
  }
}