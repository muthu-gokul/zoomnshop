import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoomnshop/pages/HomePage/LandingPage.dart';
import 'package:zoomnshop/pages/navHomeScreen.dart';

import '../../notifier/themeNotifier.dart';
import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import 'Cartpage.dart';
import 'Videocall.dart';


class OrderSuccessful extends StatefulWidget {

  @override
  _OrderSuccessfulState createState() => _OrderSuccessfulState();
}

class _OrderSuccessfulState extends State<OrderSuccessful> {
  @override
  late  double width,height,width2,height2,gridWidth;
  

  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    gridWidth=width-30;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Consumer<ThemeNotifier>(
          builder:(ctx,tn,child)=> Stack(
            children: [
              Scaffold(
                // backgroundColor: Color(0xffF7F7FF),
                body: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffF7F7FF),
                        Color(0xffffffff),
                      ],
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Image.asset("assets/images/loginpages/home.png",fit: BoxFit.cover,),
                        ),
                       SizedBox(height: 50,),
                       Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green,
                           shape: BoxShape.circle
                        ),
                        child: Icon(Icons.done,color:Colors.white,size: 30,),
                       ),
                      SizedBox(height: 5,),
                      Text('Order Successful !',style: TextStyle(fontFamily: 'RR',fontSize: 24,color: Colors.black,letterSpacing: 0.1),),
                      SizedBox(height: 5,),
                      Flexible(
                        child: Text('Congratulations on Becoming our member'
                          ,style: TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.black),),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                        },
                        child: Container(
                          height: 60,
                          width: SizeConfig.screenWidth!*0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0XFFFE316C),
                          ),
                          alignment: Alignment.center,
                          child: Text("Home Page",style: whiteRM20,),
                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
