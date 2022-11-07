import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
late TabController customerAppTabController;
RxList<dynamic> upcomingCustomerApplist=RxList();
void getCustomerAppointmentDetail(status) async{
  upcomingCustomerApplist.clear();
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getEndUserAppointment));
  params.add(ParameterModel(Key: "AppointmentStatus", Type: "String", Value: status));
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      //log("getCustomerAppointmentDetail $parsed");
      upcomingCustomerApplist.value=parsed['Table'];
    }
  });
}
void insertCustomerAppointmentDetail(List param,{bool fromLandingPage=false}) async{
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertEndUserAppointment));
  param.forEach((element) {
    params.add(ParameterModel(Key: element['dataName'], Type: "String", Value: element['value']));
  });

  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      Get.back();
      var parsed=json.decode(response[1]);
      log("insertCustomerAppointmentDetail $parsed");
      if(!fromLandingPage){
        getCustomerAppointmentDetail(getAppoiStatusByIndex(0));
      }
      else{
        CustomAlert().successAlert(parsed['TblOutPut'][0]['@Message'], "");
      }
    }
  });
}