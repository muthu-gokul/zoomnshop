
import 'dart:convert';
import 'dart:developer';

import 'package:zoomnshop/notifier/shopKeeper/skAppointmentNotifier.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../constants/sp.dart';
import '../model/parameterMode.dart';
import '../notifier/utils.dart';
import '../pages/HomePage/Videocall.dart';
import 'configuration.dart';

var videoCallBody={};
initiateCall(userId, roomId, name, roomName) async{
  videoCallBody={'user_id': userId,
    'role': await getUserRoleForCall(),
    'room_id':roomId,};
  showPreview(true,name,'https://zoomnshop.app.100ms.live/meeting/'+roomName);
}

void updateCallStatus(appointmentStatusId) async{
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.updateCallStatus));
  params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: await getSharedPrefString(SP_CURRENTCALLAPPOINTMENTID)));
  params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: await getSharedPrefString(SP_COMPANYID)));
  params.add(ParameterModel(Key: "AppointmentStatusId", Type: "String", Value: appointmentStatusId));
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      log("updateCallStatus $parsed");
      getShopKeeperAppointmentDetail(getAppoiStatusByIndex(0));
    }
  });
}