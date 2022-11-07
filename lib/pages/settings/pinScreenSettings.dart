import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:zoomnshop/api/ApiManager.dart';
import 'package:zoomnshop/api/apiUtils.dart';
import 'package:zoomnshop/notifier/utils.dart';
import 'package:zoomnshop/styles/style.dart';
import 'package:zoomnshop/utils/colorUtil.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';
import 'package:zoomnshop/widgets/customAppBar.dart';
import 'package:zoomnshop/widgets/loader.dart';
import 'package:zoomnshop/widgets/widgetUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/sizeLocal.dart';

class PinScreenSettings extends StatefulWidget {
  bool fromLogin;
  PinScreenSettings({this.fromLogin=false});
  @override
  State<PinScreenSettings> createState() => _PinScreenSettingsState();
}

class _PinScreenSettingsState extends State<PinScreenSettings> {

  bool hasPin=false;
  PinWidget pinWidget=PinWidget(pinLength: 6,onComplete: (){},);
  PinWidget confirmPinWidget=PinWidget(pinLength: 6,onComplete: (){},);
  @override
  void initState(){
    getPinStatus();
    pinWidget.onComplete=(){
      confirmPinWidget.requestFocus();
    };
    confirmPinWidget.onComplete=(){
      if(pinWidget.validate() && confirmPinWidget.validate()){
        if(pinWidget.getValue()!=confirmPinWidget.getValue()){
          CustomAlert().commonErrorAlert("Pin doesnot match...", "");
        }
        else{
          fingerPrintAllowDialog(pinWidget.getValue());
          //createPin(pinWidget.getValue());
        }
      }
    };
    super.initState();
  }

  void getPinStatus() async{
    String pinNo=await getSharedPrefString(SP_PIN);
    if(widget.fromLogin){
      setState((){
        hasPin=pinNo.isNotEmpty;
      });
      if(pinNo.isNotEmpty){
        navigateByUserType();
      }
    }
    else{
      setState((){
        hasPin=pinNo.isNotEmpty;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                CustomAppBar(title: hasPin?"Reset Pin":"Create Pin",
                  suffix: Visibility(
                      visible: widget.fromLogin,
                      child: TextButton(onPressed: (){
                    insertDeviceInfo("");
                    navigateByUserType();
                  }, child: Text("Skip        ",style: ts18(ColorUtil.red,fontfamily: 'RM',),))),
                ),
                Visibility(
                    visible: !hasPin,
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20,),
                      LeftAlignHeader(title: "Enter New Pin"),
                      pinWidget,
                      SizedBox(height: 20,),
                      LeftAlignHeader(title: "Confirm New Pin"),
                      confirmPinWidget,
                      SizedBox(height: 30,),
                      DoneBtn(
                        title: "Set Pin",
                        onDone: (){
                          if(pinWidget.validate() && confirmPinWidget.validate()){
                            if(pinWidget.getValue()!=confirmPinWidget.getValue()){
                              CustomAlert().commonErrorAlert("Pin doesnot match...", "");
                            }
                            else{
                              fingerPrintAllowDialog(pinWidget.getValue());
                              //createPin(pinWidget.getValue());
                            }
                          }
                        },
                      )
                    ],
                  )
                )

               /* Container(
                  height: 50,
                  child: Row(
                    children: [
                      ArrowBack(
                        onTap: (){
                          Get.back();
                        },
                      ),
                      Text(hasPin?"Reset Pin":"Create Pin",style: ts18(ColorUtil.primaryTextColor2),)
                    ],
                  ),
                ),*/

              ],
            ),
          ),
          Obx(() => Loader(
            value: showLoader.value,
          ))
        ],
      ),
    );
  }


  void fingerPrintAllowDialog(String pin) async{
    bool hasFingerPrint=await getSharedPrefBool(SP_HASFINGERPRINT);
    if(hasFingerPrint){
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
            clipBehavior: Clip.antiAlias,
            content: Container(
                width: SizeConfig.screenWidth!*0.85,
                decoration:BoxDecoration(
                  color:Colors.white,
                ),
                //  padding: pad,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      //SizedBox(height:20),
                      // SvgPicture.asset(img),
                      Icon(Icons.fingerprint,color: ColorUtil.primaryColor,size: 50,),
                      SizedBox(height:30),
                      Container(
                        //width: textWidth,
                        child: Text("Do you want to enable Fingerprint Authentication ?",
                          style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878),letterSpacing: 0.5,
                              height: 1.5),textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          GestureDetector(
                            onTap:(){

                              Get.back();
                              createPin(pin);
                              // cancelCallback!();
                            },
                            child: Container(
                              height: 50.0,
                              width: SizeConfig.screenWidth!*0.35,
                              //margin: EdgeInsets.only(bottom: 0,top:20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFE4E4E4),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:Color(0xFF808080).withOpacity(0.6),
                                //     offset: const Offset(0, 8.0),
                                //     blurRadius: 15.0,
                                //     // spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              child: Center(
                                child: Text("No",
                                  style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 16),
                                ),
                              ),
                            ),
                          ),



                          GestureDetector(
                            onTap:(){
                              Get.back();
                              _authenticateWithBiometrics(pin);
                            },
                            child: Container(
                              height: 50.0,
                              width: SizeConfig.screenWidth!*0.35,
                              // margin: EdgeInsets.only(bottom: 0,top:20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtil.red,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:ColorUtil.red.withOpacity(0.6),
                                //     offset: const Offset(0, 8.0),
                                //     blurRadius: 15.0,
                                //     // spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              child: Center(
                                child: Text("Yes",
                                  style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),



                    ]
                )
            ),
          )
      );
    }
    else{
      createPin(pin);
    }
  }
  final LocalAuthentication auth = LocalAuthentication();
  Future<void> _authenticateWithBiometrics(String pin) async {
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
      setSharedPrefBool(true, SP_ALLOWFINGERPRINT);
      createPin(pin);
      //navigateByUserType();
    }
    setState(() {
      //_authorized = message;
    });
  }

  void createPin(String pin) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertPin));
    params.add(ParameterModel(Key: "UserPINNumber", Type: "String", Value: pin));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
        insertDeviceInfo(pin);
        if(widget.fromLogin){
          navigateByUserType();
        }
        else{
          CustomAlert().successAlert(parsed['TblOutPut'][0]['@Message'], '');
        }
        await setSharedPrefString(pin, SP_PIN);
        pinWidget.clearValues();
        confirmPinWidget.clearValues();
        if(!widget.fromLogin) {
          getPinStatus();
        }
      }
    });
  }

  void insertDeviceInfo(pin) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertUserDevice));
    params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "DeviceInfo", Type: "String", Value: deviceData.toString()));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
      }
    });
  }
}
