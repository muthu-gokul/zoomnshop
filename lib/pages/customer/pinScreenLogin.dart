import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zoomnshop/pages/customer/customerLogin.dart';
import 'package:zoomnshop/utils/sizeLocal.dart';
import 'package:zoomnshop/widgets/loader.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../notifier/utils.dart';
import '../../styles/style.dart';
import '../../utils/colorUtil.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/widgetUtils.dart';
import '../shopKeeper/shopKeeperHomeScreen.dart';
import 'navHomeScreen.dart';

class PinScreenLogin extends StatefulWidget {
  @override
  State<PinScreenLogin> createState() => _PinScreenLoginState();
}

class _PinScreenLoginState extends State<PinScreenLogin> {

  String localMpin="";
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState(){
    checkFingerPrint();
    pinWidget.onComplete=(){
      if(pinWidget.validate()){
        login(pinWidget.getValue());
      }
    };
    super.initState();
  }

  void checkFingerPrint() async{
    localMpin = await getSharedPrefString(SP_PIN);
    print("localMpin $localMpin");
    if(Platform.isAndroid){
      bool hasFingerPrint=await getSharedPrefBool(SP_HASFINGERPRINT);
      bool allowFingerPrint=await getSharedPrefBool(SP_ALLOWFINGERPRINT);
      print("hasFingerPrint $hasFingerPrint");
      if(hasFingerPrint && allowFingerPrint){
        _authenticateWithBiometrics();
      }
      else if(localMpin.isEmpty){
        Get.off(CutomerLogin());
      }
    }
  }
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        /*_isAuthenticating = true;
        _authorized = 'Authenticating';*/
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
     /*   _isAuthenticating = false;
        _authorized = 'Authenticating';*/
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
       /* _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';*/
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    if(authenticated){
      if(localMpin.isEmpty){
        navigateByUserType();
      }
      else{
        login(localMpin);
      }
    }
    setState(() {
      //_authorized = message;
    });
  }

  PinWidget pinWidget=PinWidget(pinLength: 6,onComplete: (){

  },);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome Back...",style: ts18(ColorUtil.primaryTextColor2),),
                const SizedBox(height: 20,),
                Text("Enter Pin",style: ts18(ColorUtil.primaryTextColor2),),
                const SizedBox(height: 20,),
                pinWidget,
                const SizedBox(height: 50,),
                /*DoneBtn(
                    onDone: (){
                      //Get.off(CutomerLogin());
                      if(pinWidget.validate()){
                        login(pinWidget.getValue());
                      }
                    },
                    title: "Login"
                ),
                const SizedBox(height: 30,),*/
                DoneBtn(
                    onDone: (){
                      Get.off(CutomerLogin());
                    },
                    title: "Login with Email"
                ),
              ],
            ),
          ),
          Obx(() => Loader(value: showLoader.value,))
        ],
      ),
    ));
  }
  void login(pin) async{

    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.loginSp));
    params.add(ParameterModel(Key: "UserName", Type: "String", Value: await getSharedPrefString(SP_USEREMAIL)));
    params.add(ParameterModel(Key: "Password", Type: "String", Value: await getSharedPrefString(SP_USERPASSWORD)));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    params.add(ParameterModel(Key: "Type", Type: "String", Value: 2));
    params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "OTPNumber", Type: "String", Value: null));
    ApiManager().GetInvokeLogin(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("pin $parsed");
        var t =parsed['Table'];
        if(t.length>0){
          String ft=await getSharedPrefString(SP_FIREBASETOKEN);
          if(ft.isNotEmpty) {
            updateNotificationId(ft);
          }
          setSharedPrefString(t[0]['LoginUserId'], SP_USER_ID);

          String nb=await getSharedPrefString(SP_NOTIFICATIONBODY);
          if(nb.isEmpty){
            if(t[0]['UserTypeId']==UserType.customer.index){
              Get.off(const CustomerHomeScreen());
            }
            else if(t[0]['UserTypeId']==UserType.shopKeeper.index){
              Get.off(ShopKeeperHomeScreen());
            }
            else{
              CustomAlert().commonErrorAlert("Access Denied", "");
            }
          }
          else{
            checkNotiPurpose(jsonDecode(nb));
            setSharedPrefString("", SP_NOTIFICATIONBODY);
          }
        }
      }
    });
  }
}
