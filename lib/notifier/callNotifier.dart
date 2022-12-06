
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:zoomnshop/notifier/shopKeeper/skAppointmentNotifier.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../constants/sp.dart';
import '../model/parameterMode.dart';
import '../notifier/utils.dart';
import '../pages/HomePage/Videocall.dart';
import '../pages/videoCall/videoCall.dart';
import 'configuration.dart';

var videoCallBody={};
initiateCall(userId, roomId, name, roomName) async{
  Get.to(VideoCallPage(name: name,userId: await getSharedPrefString(SP_USER_ID),callID: roomName,))!.then((value){
    navigateByUserType();
  });
  return;
  videoCallBody={'user_id': userId,
    'role': await getUserRoleForCall(),
    'room_id':roomId,};
  showPreview(true,name,'https://zoomnshop.app.100ms.live/meeting/'+roomName);
}
initiateCallFromNoti(Map data) async{
  if(data['appointmentId'] != null && data['appointmentId']!=""){
    setSharedPrefString(data['appointmentId'], SP_CURRENTCALLAPPOINTMENTID);
    setSharedPrefString(data['clientOutletId'], SP_CURRENTCALLCLIENTOUTLETID);
  }
  Get.to(VideoCallPage(name: data['name'],userId: data['userId'],callID: data['callId'],))!.then((value){
    setSharedPrefString("", SP_NOTIFICATIONBODY);
    navigateByUserType();
  });
}

void updateCallStatus(appointmentStatusId) async{
  String aid=await getSharedPrefString(SP_CURRENTCALLAPPOINTMENTID);
  if(aid.isEmpty){
    getShopKeeperAppointmentDetail(getAppoiStatusByIndex(0));
    return;
  }
  String clientOutletId=await getSharedPrefString(SP_CURRENTCALLCLIENTOUTLETID);
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.updateCallStatus));
  params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value:aid ));
  params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: clientOutletId));
  params.add(ParameterModel(Key: "AppointmentStatusId", Type: "String", Value: appointmentStatusId));
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      log("updateCallStatus $parsed");
      getShopKeeperAppointmentDetail(getAppoiStatusByIndex(0));
      if(appointmentStatusId==7){
        setSharedPrefString("", SP_CURRENTCALLAPPOINTMENTID);
        setSharedPrefString("", SP_CURRENTCALLCLIENTOUTLETID);
      }
    }
  });
}
void updateCallStatusCustomer(appointmentStatusId,aid,coId) async{
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.updateCallStatus));
  params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value:aid ));
  params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value:coId));
  params.add(ParameterModel(Key: "AppointmentStatusId", Type: "String", Value: appointmentStatusId));
  ApiManager().GetInvoke(params).then((response) async {});
}

