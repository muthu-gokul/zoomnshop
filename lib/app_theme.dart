import 'package:flutter/material.dart';


class AppTheme {
  AppTheme._();

  static  Color restroTheme=Color(0xFFff0022);
  //static  Color restroTheme=Color(0xFF0880FF);

//2b2b30 backgrind
//unslect 5e5e60
 //1f2023 numberpad
  static const Color lightgreen=Color(0xFF4BC773);
  static const Color darkBlue=Color(0xFF111427);
  static const Color lightBlue=Color(0xFF1B1F32);
// static const Color red=Color(0xFFE34343);
 //static const Color red=Color(0xFFD22D2C);
 static const Color red=Color(0xFFff0022);
 static const Color darkgrey=Color(0xFF000821);
 static const Color lightgrey=Color(0xFF1B1F32);
 static const Color tableservietext=Color(0xFFAABAFE);
 static const Color f54629=Color(0xFF54629F);
 static const Color f3f3f3=Color(0xFFF3F3F3);
 static const Color g353535=Color(0xFF353535);
 static const Color g35353=Color(0xFF585858);
 static const Color white=Color(0xFFFFFFFF);
 static const Color reportHeaderLite=Color(0xFFE9E9E9);

  static const Color f727272=Color(0xFF727272);
  static const Color noParcelChargeColor=Color(0xFFFBDEE0);
  static const Color guestNo=Color(0xFFB5B5B5);

  static const Color reportServiceProgress=Color(0xFFEBEBEB);

  static const Color darkGrey1=Color(0xFF454449);
  static const Color darkGrey2=Color(0xFF212529);
 static const Color bgColor=Color(0xFF3B3B3D);

 static  Color gridTextColor=Color(0xFF787878);
 static  Color gridBgColor=Color(0xFFF8F9FB);
 static  Color gridExcelBgColor=Color(0xFFF1F2F4);
 static  Color reportGridBottomBorderColor=Color(0xFFdfdfdf);
 static  TextStyle reportGridHeaderTS=TextStyle(fontFamily: 'RM',fontSize: 18,color: Color(0xFF6d7c94),letterSpacing: 0.2);
 static  TextStyle reportGridValueTS=TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xFF6d7c94));

  //TS -- TextStyle

  static TextStyle textStyle=TextStyle(fontFamily: 'RB',fontSize: 18,color: Color(0xFF555555),letterSpacing: 0.1);
  static TextStyle openItemTS=TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xFF555555),letterSpacing: 0.1);
  static TextStyle openItemTSWhite=TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xFFFFFFFF),letterSpacing: 0.1);

  static const Color openItemBoxShadowColor=Color(0xFF454545);

  static TextStyle textStyle18=TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xFF000000));
  static TextStyle searchHintTS=TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.grey);
  static TextStyle inactiveDisTS=TextStyle(fontFamily: 'RR',fontSize: 20,color: Colors.grey);
  static TextStyle activeDisTS=TextStyle(fontFamily: 'RR',fontSize: 20,color: Colors.white);
  static TextStyle white20TS=TextStyle(fontFamily: 'RR',fontSize: 20,color: Colors.white);
  static TextStyle white16TS=TextStyle(fontFamily: 'RR',fontSize: 16,color: Colors.white);
  static TextStyle white18TS=TextStyle(fontFamily: 'RR',fontSize: 18,color: Colors.white);
 static  TextStyle hintText=TextStyle(fontFamily: 'RR',fontSize: 16,color: addNewTextFieldText.withOpacity(0.5));
  static TextStyle saleGridValueTS=TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xFF757575));
  static TextStyle saleGridValueTSM=TextStyle(fontFamily: 'RM',fontSize: 18,color: Color(0xFF757575));

  //RDB--Report DashBoard
  static TextStyle RDBserviceNameTS=TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xFF777A92));
  static TextStyle RDBservicePriceTS=TextStyle(fontFamily: 'RB',fontSize: 25,color: Color(0xFF7D7D7D));
  static TextStyle RDBserviceDiscountTS=TextStyle(fontFamily: 'RB',fontSize: 15,color: Color(0xFFE95970));
  static TextStyle RDBserviceCurrentday=TextStyle(fontFamily: 'RL',fontSize: 15,color: Color(0xFFA1A1A1));


  static TextStyle itemEditPopUpText=TextStyle(fontFamily: 'RR',fontSize: 16,color: Color(0xFF6D6D6D));
  static TextStyle itemEditPopUpTextRight=TextStyle(fontFamily: 'RR',fontSize: 16,color: AppTheme.red);

 static  Color hintColor=Color(0xFFC5C5C5);


  static  Color appBarColor=Color(0xFF010822);
  static  Color secondaryBgColor=Color(0xFF1C1F32);
  static  Color swiggy=Color(0xFFF7881F);
  static  Color zomato=Color(0xFFCD212F);
  static  Color dunzo=Color(0xFF01FFA7);
 static  Color others=Colors.deepPurpleAccent;
 static  Color addNewTextFieldText=Color(0xFF434343);
 static const Color addNewTextFieldBorder=Color(0xFFCECECE);
 static  Color grey=Color(0xFF787878);

  static  Color billPreHeader=Color(0xFF505050);
  static TextStyle billPre16=TextStyle(fontFamily: 'RR',color: AppTheme.billPreHeader,fontSize: 16);

 static TextStyle billPreFooterTotalVTs=TextStyle(fontFamily: 'RM',color: Color(0xFF15CF15),fontSize: 20);
 static TextStyle billPreFooterTotalTs=TextStyle(fontFamily: 'RM',color: Color(0xFF15CF15),fontSize: 18);
 static TextStyle billPreFooterTitleTs=TextStyle(fontFamily: 'RM',color: AppTheme.billPreHeader,fontSize: 16);
 static TextStyle billPreFooterValueTs=TextStyle(fontFamily: 'RM',color: AppTheme.billPreHeader,fontSize: 18);
 static TextStyle billInstructionsTs=TextStyle(fontFamily: 'RR',color: Color(0xFF363636),fontSize: 14);

 static TextStyle textFormStyle= TextStyle(fontFamily: 'RR',fontSize: 20,color: Color(0xFF707070));

 static  Color waiterBorderColor=Color(0xFFe0e0e0);
 static  Color waiterBgColor=Color(0xFFf1f1f1);
 static  Color waiterTextColor=Color(0xFF7F7F7F);

static BoxShadow redShadow= BoxShadow(
     color:Color(0xFFE34343).withOpacity(0.7),
     offset: const Offset(0, 9.0),
     blurRadius: 25.0,
     spreadRadius: 1
 );

 //rawScrollBar Properties
 static const Color srollBarColor=Colors.grey;
 static const double scrollBarRadius=5.0;
 static const double scrollBarThickness=4.0;

 static TextStyle bgColorTS=TextStyle(fontFamily: 'RR',color: AppTheme.bgColor,fontSize: 16);
 static const Color yellowColor=Color(0xFFff0022);
 static  Color gridbodyBgColor=Color(0xFFF6F7F9);

 static  Color avatarBorderColor=Color(0xFFC7D0D8);
}
