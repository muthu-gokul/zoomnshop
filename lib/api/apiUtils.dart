
import 'dart:convert';

import 'package:zoomnshop/notifier/configuration.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../styles/constants.dart';
import '../model/parameterMode.dart';

int loginUserId=0;
String databaseName="";
int outletId=0;
String outletName="";

String GetBaseUrl(){
  return "https://scutisoft.in/zoomnshop";
  return "http://94.130.140.81/ZoomNShop";
}
String GetImageBaseUrl(){
  //return "http://94.130.140.81/ZoomNShop/AppAttachments/";
  return "https://scutisoft.in/zoomnshop/AppAttachments/";
}


getParameterEssential({bool needOutletId=false}) async{
  return [
    ParameterModel(Key: "LoginUserId", Type: "int", Value: await getLoginId()),
    ParameterModel(Key: "IsMobile", Type: "int", Value: 1),
    ParameterModel(Key: "database", Type: "String", Value: getDatabase()),
    ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()),
    if(needOutletId)
      ParameterModel(Key: "OutletId", Type: "String", Value: await getOutletId()),
  ];
}

getLoginId() async{
  //SharedPreferences sp=await SharedPreferences.getInstance();
  // return sp.getInt("LoginUserId");
  return await getSharedPrefString(SP_USER_ID);
}

getDatabase(){
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return "ZoomNShop";
}

getOutletId() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletId;
}
getOutletName() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletName;
}

Future<List> getMasterDrp(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.MasterdropDown));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));
  var result=[];
  try{
    await ApiManager().GetInvoke(parameters).then((value) {
      if(value[0]){
        var parsed=jsonDecode(value[1]);
        //print(parsed);
        var table=parsed['Table'] as List;
        if(table.isNotEmpty){
          result=table;
        }
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}
Future<Map> getMasterDrpMap(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  //parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));
  var result={};
  try{
    await ApiManager().GetInvoke(parameters).then((value) {
      if(value[0]){
        var parsed=jsonDecode(value[1]);
        result=parsed;
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}



/*
List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getDeviceStatus));
    params.add(ParameterModel(Key: "UserPINNumber", Type: "String", Value: pin));
    ApiManager().GetInvoke(params).then((response){
      if(response[0]){
        var parsed=json.decode(response[1]);
      }
    });
* */