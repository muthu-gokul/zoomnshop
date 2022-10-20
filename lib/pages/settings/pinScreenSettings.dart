import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/api/ApiManager.dart';
import 'package:zoomnshop/api/apiUtils.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';
import 'package:zoomnshop/widgets/customAppBar.dart';
import 'package:zoomnshop/widgets/loader.dart';
import 'package:zoomnshop/widgets/widgetUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/sizeLocal.dart';

class PinScreenSettings extends StatefulWidget {
  const PinScreenSettings({Key? key}) : super(key: key);

  @override
  State<PinScreenSettings> createState() => _PinScreenSettingsState();
}

class _PinScreenSettingsState extends State<PinScreenSettings> {

  bool hasPin=false;
  PinWidget pinWidget=PinWidget(pinLength: 6);
  PinWidget confirmPinWidget=PinWidget(pinLength: 6);
  @override
  void initState(){
    getPinStatus();
    super.initState();
  }

  void getPinStatus() async{
    String pinNo=await getSharedPrefString(SP_PIN);
    setState((){
      hasPin=pinNo.isNotEmpty;
    });
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
                CustomAppBar(title: hasPin?"Reset Pin":"Create Pin"),
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
                            createPin(pinWidget.getValue());
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

  void createPin(String pin) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertPin));
    params.add(ParameterModel(Key: "UserPINNumber", Type: "String", Value: pin));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
        insertDeviceInfo(pin);
        CustomAlert().successAlert(parsed['TblOutPut'][0]['@Message'], '');
        await setSharedPrefString(pin, SP_PIN);
        pinWidget.clearValues();
        confirmPinWidget.clearValues();
        getPinStatus();

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
