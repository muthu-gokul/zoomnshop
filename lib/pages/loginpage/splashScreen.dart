import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zoomnshop/api/apiUtils.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/pages/loginpage/login.dart';
import 'package:zoomnshop/styles/constants.dart';
import 'package:zoomnshop/utils/sizeLocal.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/callNotifier.dart';
import '../../notifier/notification/myNotification.dart';
import '../customer/customerLogin.dart';
import '../customer/pinScreenLogin.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> implements MyNotificationCallBack{

  final LocalAuthentication auth = LocalAuthentication();
  late MyNotification myNotification;
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
    myNotification=MyNotification();
    myNotification.setMyCallBack(this);
    myNotification.registerNotification();
    myNotification.checkForInitialMessage();
    initPlatformState().then((value){
      print("deive Id ${getDeviceId()}");
      checkUserData();
      getFirebaseToken();
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

  void getFirebaseToken() async{
    String ft=await getSharedPrefString(SP_FIREBASETOKEN);
    FirebaseMessaging.instance.getToken().then((value){
      log("FT $value");
      if(ft!=value){

        FirebaseDatabase.instance.ref().child("tokens/${getDeviceId().toString().replaceAll(".", "")}").set({"token":value,"LastUpdated":DateTime.now().toString()});
        setSharedPrefString(value, SP_FIREBASETOKEN);
      }

    });

  }

  @override
  void onNotificationReceived(dynamic valueArray, NotificationMode type) {
    if(type==NotificationMode.onMessage){
      checkNotiPurpose(valueArray);
    }
    else if(type==NotificationMode.onMessageClickOpen){
      checkNotiPurpose(valueArray);
    }
    else if(type==NotificationMode.initialMessage){
      checkNotiPurpose(valueArray);
    }
    log("onNotificationReceived $valueArray");
  }

  void checkNotiPurpose(Map data){
    if(data["notificationPurpose"]=="Call"){
      callPurpose(data);
    }
  }

  void callPurpose(Map data){
    initiateCallFromNoti(data);
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
