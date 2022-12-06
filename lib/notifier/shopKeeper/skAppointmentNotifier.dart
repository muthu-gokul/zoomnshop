import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../utils.dart';

RxList<dynamic> upcomingSKAppoList=RxList();
late TabController sktabController;
void getShopKeeperAppointmentDetail(status) async{
 upcomingSKAppoList.clear();
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getShopKeeperAppointment));
  params.add(ParameterModel(Key: "AppointmentStatus", Type: "String", Value: status));
  //params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));

  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      log("getShopKeeperAppointmentDetail $parsed");
      upcomingSKAppoList.value=parsed['Table'];
    }
  });
}

List<ParameterModel> acceptRejectParms=[
  ParameterModel(Key: "AppointmentId", Type: "String", Value: ""),
  ParameterModel(Key: "IsAccept", Type: "int", Value: false),
  ParameterModel(Key: "RoomUniqueId", Type: "String", Value: null),
  ParameterModel(Key: "CallUserId", Type: "String", Value: null),
];
void acceptAppointment() async{
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.acceptRejectShopKeeperAppointment));
  params.addAll(acceptRejectParms);
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      log("acceptAppointment $parsed");
      try{
        getShopKeeperAppointmentDetail(getAppoiStatusByIndex(sktabController.index));
      }catch(e){
        getShopKeeperAppointmentDetail(getAppoiStatusByIndex(0));
      }
    }
  });
}

