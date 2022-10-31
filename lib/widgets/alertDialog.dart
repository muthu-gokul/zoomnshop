
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colorUtil.dart';
import 'toast.dart';

class CustomAlert{

  RoundedRectangleBorder alertRadius=RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),);


  VoidCallback? callback;
  VoidCallback? cancelCallback;
  CustomAlert({this.callback,this.cancelCallback});

  void show(BuildContext context,String text,int duration){
    Toast.show(text,
        context,
        duration: Toast.lengthShort,
        gravity: Toast.center,
        textStyle: TextStyle(color: Colors.white,fontSize: 50,fontFamily: 'RL',)
    );
  }

  void selectTableAlert(BuildContext context,String img,String title,bool isSvg){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:360,
              width:340,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[

                    isSvg?SvgPicture.asset(img):Image.asset(img),
                    SizedBox(height:20),
                    Container(
                      width: 280,
                      child: Text(title,
                          style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878),letterSpacing: 0.5,height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]
              )
          ),
        )

    );
  }

  void commonErrorAlert(String title,String des){
    showDialog(
        context: Get.context!,
        builder: (ctx) => AlertDialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          content: Container(
             /* height:280,*/
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    SizedBox(height:10),
                    //SvgPicture.asset('assets/errors/error-icon.svg'),
                    Icon(Icons.error_outline,color: ColorUtil.red,size: 30,),
                    SizedBox(height:30),
                    Text(title,
                        style:TextStyle(fontFamily:'RM',fontSize:22,color:ColorUtil.red),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(des,
                          style:TextStyle(fontFamily:'RL',fontSize:16,color:Color(0xFF787878)),textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                  ]
              )
          ),
        )

    );
  }

  void settingsOff(BuildContext context,String title,){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:250,
              width:350,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:10),
                    SvgPicture.asset('assets/errors/error-icon.svg'),
                    SizedBox(height:30),
                    Text("Disabled",
                        style:TextStyle(fontFamily:'RM',fontSize:22,color:ColorUtil.red),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    /*Text(des,
                        style:TextStyle(fontFamily:'RL',fontSize:18,color:Color(0xFF787878)),textAlign: TextAlign.center,
                    ),*/
                  ]
              )
          ),
        )

    );
  }

  void commonErrorAlert2(BuildContext context,String title,String? des){
    if(des==null){
      des="";
    }
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:des!.length>200?450:280,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:10),
                    SvgPicture.asset('assets/errors/error-icon.svg'),
                    SizedBox(height:30),
                    Text(title,
                      style:TextStyle(fontFamily:'RM',fontSize:18,color:ColorUtil.red),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(des,
                          style:TextStyle(fontFamily:'RL',fontSize:16,color:Color(0xFF787878)),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]
              )
          ),
        )

    );
  }
  void successAlert(String title,String des){
    if(des==null){
      des="";
    }
    showDialog(
        context: Get.context!,
        builder: (ctx) => AlertDialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          content: Container(
         /*     height:des!.length>200?450:280,*/
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                mainAxisSize: MainAxisSize.min,
                  children:[
                    SizedBox(height:10),
                    Image.asset('assets/images/sucess.gif'),
                    SizedBox(height:30),
                    Text(title,
                      style:TextStyle(fontFamily:'RM',fontSize:18,color:Color(0xFF0C9A6A)),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(des,
                          style:TextStyle(fontFamily:'RL',fontSize:16,color:Color(0xFF787878)),textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ]
              )
          ),
        )

    );
  }

  void billSuccessAlert(BuildContext context,String img,String title,String des,String amt){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (ctx)
           {
             Future.delayed(Duration(seconds: 3), () {
               Navigator.of(context).pop(true);
             });
            return Dialog(
              shape: alertRadius,
              clipBehavior: Clip.antiAlias,
        child: Container(
            height: 450,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
            ),

            child: Column(
                children: [
                  SizedBox(height: 10),
                  // SvgPicture.asset(img),
                  Image.asset("assets/images/sucess.gif"),
                  SizedBox(height: 30),
                  Text(title,
                    style: TextStyle(fontFamily: 'RM',
                        fontSize: 18,
                        color: Color(0xFF0C9A6A)), textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(des,
                    style: TextStyle(fontFamily: 'RL',
                        fontSize: 20,
                        color: Color(0xFF787878)), textAlign: TextAlign.center,
                  ), SizedBox(height: 10),
                  Text(amt,
                    style: TextStyle(fontFamily: 'RB',
                        fontSize: 22,
                        color: Color(0xFF787878)), textAlign: TextAlign.center,
                  ),
                ]
            )
        ),
      );
           }
    );
  }

  void dynamicTableErrorAlert(BuildContext context,String img,String title,String des){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:270,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Padding(
                padding: const EdgeInsets.only(left:10,right: 10),
                child: Column(
                    children:[
                      SizedBox(height:10),
                      SvgPicture.asset(img),
                      // SizedBox(height:10),
                      Text(title,
                          style:TextStyle(fontFamily:'RM',fontSize:22,color:ColorUtil.red),textAlign: TextAlign.center,
                      ),
                      SizedBox(height:15),
                      Text(des,
                          style:TextStyle(fontFamily:'RL',fontSize:18,color:Color(0xFF787878)),textAlign: TextAlign.center,
                      ),
                    ]
                ),
              )
          ),
        )

    );
  }

  void dialogWithCallBack(BuildContext context,String img,String title,String des){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:330,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),

              child:Column(
                  children:[
                    SizedBox(height:20),
                    // SvgPicture.asset(img),
                    Image.asset("assets/errors/bill-popup.png"),
                    SizedBox(height:20),
                    Text(title,
                        style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878))),
                    GestureDetector(
                      onTap: callback,
                      child: Container(
                        height: 60.0,
                        width: 120.0,
                        margin: EdgeInsets.only(bottom: 20,top:20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorUtil.red,
                            boxShadow: [
                              BoxShadow(
                                color:ColorUtil.red.withOpacity(0.6),
                                offset: const Offset(0, 8.0),
                                blurRadius: 15.0,
                                // spreadRadius: 2.0,
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text("Done",
                            style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                          ),
                        ),
                      ),
                    )

                  ]
              )
          ),
        )

    );
  }

  void yesOrNoDialog(BuildContext context,String img,String title,){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:360,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:20),
                    // SvgPicture.asset(img),
                    Image.asset("assets/errors/bill-popup.png"),
                    SizedBox(height:20),
                    Text(title, style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878)),textAlign: TextAlign.center,),

                    SizedBox(height:20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        GestureDetector(
                          onTap:cancelCallback,
                          child: Container(
                            height: 60.0,
                            width: 150.0,
                            margin: EdgeInsets.only(bottom: 20,top:20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFE4E4E4),
                                boxShadow: [
                                  BoxShadow(
                                    color:Color(0xFF808080).withOpacity(0.6),
                                    offset: const Offset(0, 8.0),
                                    blurRadius: 15.0,
                                    // spreadRadius: 2.0,
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text("Cancel",
                                style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 16),
                              ),
                            ),
                          ),
                        ),



                        GestureDetector(
                          onTap: callback,
                          child: Container(
                            height: 60.0,
                            width: 150.0,
                            margin: EdgeInsets.only(bottom: 20,top:20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtil.red,
                                boxShadow: [
                                  BoxShadow(
                                    color:ColorUtil.red.withOpacity(0.6),
                                    offset: const Offset(0, 8.0),
                                    blurRadius: 15.0,
                                    // spreadRadius: 2.0,
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text("Done",
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
  void yesOrNoDialog2(String img,String title,bool isSvg,
      {double imgHeight=50.0,EdgeInsets pad=const EdgeInsets.all(20),double hei=360,double textWidth=200}){
    showDialog(
      barrierDismissible: false,
        context: Get.context!,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
             height:hei,
              width:330,
              decoration:BoxDecoration(
                color:Colors.white,
              ),
              padding: pad,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    //SizedBox(height:20),
                    // SvgPicture.asset(img),
                    isSvg?SvgPicture.asset(img,height: imgHeight,):Image.asset(img,height: imgHeight,),
                    SizedBox(height:30),
                    Container(
                      width: textWidth,
                      child: Text(title,
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
                            cancelCallback!();
                          },
                          child: Container(
                            height: 50.0,
                            width: 140.0,
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
                            callback!();
                          },
                          child: Container(
                            height: 50.0,
                            width: 140.0,
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

  void clearDiscountyesOrNoDialog(BuildContext context,String img,String title,){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:360,
              width:400,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:20),
                     SvgPicture.asset("assets/errors/error-icon.svg"),
                    // Image.asset("assets/errors/bill-popup.png"),
                    SizedBox(height:30),
                    Text(title, style:TextStyle(fontFamily:'RR',fontSize:23,color:Color(0xFF787878)),textAlign: TextAlign.center,),


                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 60.0,
                            width: 150.0,
                            margin: EdgeInsets.only(bottom: 20,top:20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFE4E4E4),
                                boxShadow: [
                                  BoxShadow(
                                    color:Color(0xFF808080).withOpacity(0.6),
                                    offset: const Offset(0, 8.0),
                                    blurRadius: 15.0,
                                    // spreadRadius: 2.0,
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text("Cancel",
                                style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 16),
                              ),
                            ),
                          ),
                        ),



                        GestureDetector(
                          onTap: callback,
                          child: Container(
                            height: 60.0,
                            width: 150.0,
                            margin: EdgeInsets.only(bottom: 20,top:20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtil.red,
                                boxShadow: [
                                  BoxShadow(
                                    color:ColorUtil.red.withOpacity(0.6),
                                    offset: const Offset(0, 8.0),
                                    blurRadius: 15.0,
                                    // spreadRadius: 2.0,
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text("Done",
                                style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height:20),

                  ]
              )
          ),
        )

    );
  }

  void networkIssue(BuildContext context,String text,int duration){
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) {
          Future.delayed(Duration(milliseconds: duration), () {
            Navigator.of(context).pop(true);
          });
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: GestureDetector(
                onTap: (){
                  // Navigator.of(context).pop(true);
                },
                child: Container(
                  height: 350,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.3)
                  ),
                  child: Center(
                      child: Text(text,style: TextStyle(color: Colors.white,fontSize: 100,fontFamily: 'QR'),textAlign: TextAlign.center,)
                  ),

                ),
              ),
            ),
          );
        }
    );
  }

  void getPremiumAlert(BuildContext context){
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
          shape: alertRadius,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height:300,
              width:450,
              decoration:BoxDecoration(
                color:Colors.white,
              ),

              child:Column(
                  children:[
                    SizedBox(height:35),
                    SvgPicture.asset('assets/errors/premium-icon.svg'),
                    SizedBox(height:20),
                    Text("Get Premium",
                      style:TextStyle(fontFamily:'RM',fontSize:50,color:Color(0xFF666878)),textAlign: TextAlign.center,
                    ),
                    SizedBox(height:10),
                    RichText(
                      text: TextSpan(
                          text: 'Access for Exciting ',
                          style: TextStyle(fontFamily:'RR',fontSize:20,color:Color(0xFF797983)),
                          children: <TextSpan>[
                            TextSpan(text: 'Features',
                                style: TextStyle(fontFamily:'RR',fontSize:19,color:ColorUtil.red),

                            )
                          ]
                      ),
                    ),
                    // Text("Access for Exciting Features",
                    //   style:TextStyle(fontFamily:'RR',fontSize:20,color:Color(0xFF797983)),textAlign: TextAlign.center,
                    // ),
                  ]
              )
          ),
        )

    );
  }

}


