
import 'dart:convert';

import 'package:get/get.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../constants/sp.dart';
import '../model/parameterMode.dart';








Future<List> getMasterDrp(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));

  //print(body);
  var result=[];
  try{
    await ApiManager().GetInvoke(parameters).then((value) {
      // print(value);
      if(value[0]){
        var parsed=jsonDecode(value[1]);
        print(parsed);
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
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));

  var body={
    "Fields": parameters.map((e) => e.toJson()).toList()
  };
 // print(body);
  var result={};
  try{
    await ApiManager().GetInvoke(parameters,).then((value) {
      // print(value);
      if(value[0]){
        var parsed=jsonDecode(value[0]);
        result=parsed;
        // var table=parsed['Table'] as List;
        // if(table.isNotEmpty){
        //   result=table;
        // }
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}