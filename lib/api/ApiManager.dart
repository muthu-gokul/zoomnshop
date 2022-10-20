import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/parameterMode.dart';
import '../widgets/alertDialog.dart';
import 'apiUtils.dart';


var showLoader=false.obs;
class ApiManager{
  int timeOut=120;
  String invokeUrl="";
  Future<List> GetInvoke(List<ParameterModel> parameterList,{isNeedErrorAlert=true}) async {
    showLoader.value=true;
    try{
      //log(json.encode(parameterList));
      invokeUrl=GetBaseUrl()+"/api/Mobile/GetInvoke";
      var body={
        "Fields": parameterList.map((e) => e.toJson()).toList()
      };
      final response = await http.post(Uri.parse(invokeUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme());
      showLoader.value=false;
      if(response.statusCode==200){
        return [true,response.body];
      }
      else{
        var msg;
        print("${response.statusCode} ${response.body}");
        msg=json.decode(response.body);
        if(isNeedErrorAlert)
          CustomAlert().commonErrorAlert(msg['Message'], "");
        return [false,msg['Message']];
      }
    }
    catch(e){
      print("ee $e");
      showLoader.value=false;
      //CustomAlert().commonErrorAlert("Server Error", "$e");
      return [false,"Catch Api"];
    }
  }

  Future<List> GetInvokeLogin(List<ParameterModel> parameterList) async {
    try{
      print(json.encode(parameterList));
      //var url="https://scutisoft.in/QMS_UAT_Test/api/Login/InvokeSignIn";
      //var url=GetBaseUrl()+"/api/Login/InvokeSignIn";
      var url=GetBaseUrl()+"/api/Mobile/GetInvoke";
      var body={
        "Fields": parameterList.map((e) => e.toJson()).toList()
      };
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme());
      showLoader.value=false;
      if(response.statusCode==200){
        return [true,response.body];
      }
      else{
        var msg;
        msg=json.decode(response.body);
        CustomAlert().commonErrorAlert(msg['Message'], "");
        return [false,response];
      }
    }
    catch(e){
      print("ee $e");
      CustomAlert().commonErrorAlert("Server Error", "$e");
      return [false,"Catch Api"];
    }
  }

  onTme(){
    showLoader.value=false;
    return [false,"Connection TimeOut"];
  }
}
/*
http.post(url,
body: json.encode(body),
headers: { 'Content-type': 'application/json',
'Accept': 'application/json',
"Authorization": "Some token"},
encoding: encoding)*/
