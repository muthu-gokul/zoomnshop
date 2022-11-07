import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zoomnshop/api/apiUtils.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/pages/loginpage/login.dart';
import 'package:zoomnshop/styles/constants.dart';
import 'package:zoomnshop/utils/sizeLocal.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../customer/customerLogin.dart';
import '../customer/pinScreenLogin.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final LocalAuthentication auth = LocalAuthentication();

  navigate(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(APPTYPE==2 || APPTYPE==1){
        Get.off(CutomerLogin());
      }
      else{
        Get.off(LoginPage());
      }

    });
  }

  @override
  void initState(){
    initPlatformState().then((value){
      print("deive Id ${getDeviceId()}");
      checkUserData();
    });
    if(Platform.isAndroid){
      _checkBiometrics();
    }
    super.initState();
  }

  void checkUserData() async{
    String userId=await getSharedPrefString( SP_USER_ID);
    if(userId.isEmpty){
      navigate();
    }
    else{
      getDeviceStatus(userId);
    }
  }

  void getDeviceStatus(userId) async{
    String pin=await getSharedPrefString(SP_PIN);
    //log("pin $pin");
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getDeviceStatus));
    params.add(ParameterModel(Key: "LoginUserId", Type: "String", Value: userId));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    params.add(ParameterModel(Key: "database", Type: "String", Value: getDatabase()));
    print(jsonEncode(params));
    ApiManager().GetInvoke(params).then((response){
      if(response[0]){
        try{
          var parsed=json.decode(response[1]);
          log("$parsed");
          var t=parsed['Table'];
          if(t[0]['IsRegistered']){
            if(pin.isNotEmpty){
              setSharedPrefString(t[0]['TokenNumber'], SP_TOKEN);
              Get.off(PinScreenLogin());
            }
            else{
              navigate();
            }
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

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }
    setSharedPrefBool(canCheckBiometrics, SP_HASFINGERPRINT);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //navigate();
    //return Container();
    topPadding=MediaQuery.of(context).padding.top;
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
