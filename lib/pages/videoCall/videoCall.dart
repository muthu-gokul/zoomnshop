import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../notifier/callNotifier.dart';
import '../../notifier/configuration.dart';
import '../../notifier/shopKeeper/skCartNotifier.dart';
import '../../widgets/closeButton.dart';

class VideoCallPage extends StatelessWidget {
  final String callID;
  final String userId;
  final String name;

  VideoCallPage({
    Key? key,
    required this.callID,
    required this.userId,
    required this.name,
  }) : super(key: key){
    init();
  }
  var userTypeId="0".obs;
  void init () async{
    userTypeId.value=await getSharedPrefString(SP_USERTYPEID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ZegoUIKitPrebuiltCall(
            appID: 209573504,
            appSign: "3a25540ded230675167c3f4d7bfb104d7c9f0fd50eec918c5aaf23c220ec4d9b",
            userID: userId,
            userName: name,
            callID: callID,
            config: ZegoUIKitPrebuiltCallConfig.groupVideoCall(),
            onDispose: (){
              log("onDisomnse");
              updateCallStatus(7);
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Obx(() => Visibility(
                visible: userTypeId.value==UserType.shopKeeper.index.toString(),
                child: CloseBtn(
                  height: 40,
                  icon: Icons.camera_alt_outlined,
                  onTap: (){
                    showProductAddPopUp();
                  },
                ))),
          )
        ],
      ),
    );
  }
}