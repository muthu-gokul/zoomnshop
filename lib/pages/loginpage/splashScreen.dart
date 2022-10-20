import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import 'package:zoomnshop/pages/loginpage/login.dart';
import 'package:zoomnshop/utils/sizeLocal.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import 'pinScreenLogin.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigate(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Get.off(LoginPage());
    });
  }

  @override
  void initState(){
    initPlatformState().then((value){
      print("deive Id ${getDeviceId()}");
      checkUserData();
    });
    super.initState();
  }

  void checkUserData() async{
    String userId=await getSharedPrefString( SP_USER_ID);
    print("userid $userId");
    if(userId.isEmpty){
      navigate();
    }
    else{
      getDeviceStatus(userId);
    }
  }

  void getDeviceStatus(userId){
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getDeviceStatus));
    params.add(ParameterModel(Key: "LoginUserId", Type: "String", Value: userId));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    ApiManager().GetInvoke(params).then((response){
      if(response[0]){
        try{
          var parsed=json.decode(response[1]);
          log("$parsed");
          var t=parsed['Table'];
          if(t[0]['IsRegistered']){
            setSharedPrefString(t[0]['TokenNumber'], SP_TOKEN);
            Get.off(PinScreenLogin());
          }
          else{
            navigate();
          }
        }catch(e){
          navigate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //navigate();
    //return Container();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          LinearProgressIndicator(color: Colors.red,backgroundColor: Colors.red.withOpacity(0.5),)
        ],
      ),
    );
  }
}
