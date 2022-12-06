import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoomnshop/pages/settings/pinScreenSettings.dart';
import 'package:zoomnshop/styles/style.dart';
import 'package:zoomnshop/utils/colorUtil.dart';

import '../../utils/sizeLocal.dart';

class SettingsHomePage extends StatefulWidget {
  VoidCallback voidCallback;
  SettingsHomePage({required this.voidCallback});

  @override
  State<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends State<SettingsHomePage> {

  List settingsList=[
    "Pin Setting"
  ];

  void clickHandler(int index){
    if(index==0){
      Get.to(PinScreenSettings());
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            Container(
              height: 100,
              margin:  EdgeInsets.only(left:15.0,right: 15.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap:(){
                        widget.voidCallback();
                      },
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset('assets/images/loginpages/menu-icon.png',height: 30,fit: BoxFit.cover,width: 50,)
                      )
                  ),
                  SizedBox(width: 5,),
                  Text('Settings',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1)),

                ],
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: settingsList.length,
                itemBuilder: (ctx,i){
                  return GestureDetector(
                    onTap: (){
                      clickHandler(i);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 20),
                      child: Text("${settingsList[i]}",style: ts18(ColorUtil.primaryTextColor2),),
                    ),
                  );
                },
                separatorBuilder: (ctx,i){
                  return Divider(color: ColorUtil.primaryTextColor1,);
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
