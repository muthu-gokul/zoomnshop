import 'dart:convert';
import 'dart:developer';

import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';

void getCustomerAppointmentDetail() async{
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getEndUserAppointment));
  params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: null));
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){
      var parsed=json.decode(response[1]);
      log("getCustomerAppointmentDetail $parsed");

    }
  });
}