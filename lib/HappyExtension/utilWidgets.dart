import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/sizeLocal.dart';

TextStyle errorTS=TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xFFE34343));


class HiddenController extends StatelessWidget {
  bool hasInput;
 // var value="".obs;

  HiddenController({this.hasInput=true,});

  Rxn value=Rxn();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Obx(() => Text("${value.value}")),
    );
  }

  getType(){
    return 'hidden';
  }
  getValue(){
    return value.value;
  }

  setValue(var val){
    value.value=val;
  }
}
Color addNewTextFieldText=Color(0xFF787878);
Color disableColor=Color(0xFFe8e8e8);
Color addNewTextFieldBorder=Color(0xFFCDCDCD);
const Color addNewTextFieldFocusBorder=Color(0xFF6B6B6B);
class AddNewLabelTextField extends StatelessWidget {
  bool isEnabled;
  String? labelText;
  double scrollPadding;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function(String)? onChange;
  VoidCallback? ontap;
  TextInputFormatter? textInputFormatter;
  VoidCallback? onEditComplete;
  bool isObscure;
  int? maxlines;
  int? textLength;
  String regExp;

  bool hasInput;
  bool required;
  String dataname;
  late TextEditingController textEditingController;

  AddNewLabelTextField({this.labelText,this.scrollPadding=270.0,this.textInputType:TextInputType.text,
    this.prefixIcon,this.ontap,this.onChange,this.textInputFormatter,this.isEnabled=true,this.suffixIcon,this.onEditComplete,
    this.isObscure=false,this.maxlines=1,this.textLength=null,this.regExp='[A-Za-z0-9@.,]',this.hasInput=true,this.required=false,required this.dataname}){
    textEditingController= new TextEditingController();
  }
  var isValid=true.obs;
  var errorText="* Required".obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  maxlines!=null? Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left:20,right:20,top:15,),
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.transparent
          ),
          child:  TextFormField(
            enabled: isEnabled,
            onTap: ontap,
            obscureText: isObscure,
            obscuringCharacter: '*',
            scrollPadding: EdgeInsets.only(bottom: scrollPadding),
            style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
            controller: textEditingController,
            decoration: InputDecoration(
                fillColor:isEnabled?Colors.white:disableColor,
                filled: true,
                labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
                border:  OutlineInputBorder(
                    borderSide: BorderSide(color: addNewTextFieldBorder)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: addNewTextFieldBorder)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:addNewTextFieldFocusBorder)
                ),
                labelText: labelText,
                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon



            ),
            maxLines: maxlines,
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            // inputFormatters:  <TextInputFormatter>[
            //
            //   //textInputFormatter
            // ],

            inputFormatters: [
              LengthLimitingTextInputFormatter(textLength),
              FilteringTextInputFormatter.allow(RegExp(regExp)),
            ],
            onChanged: (v){
              onChange!(v);
            },
            onEditingComplete: (){
              onEditComplete!();
            },
          ),
        ),
        Obx(
                ()=>isValid.value?Container():Container(
                margin:  EdgeInsets.only(left:20,right:20,top:15,),
                child: Text(errorText.value,style: errorTS,)
            )
        ),
      ],
    ):
    Container(

      margin: EdgeInsets.only(left:20,right:20,top:15,),
      //    height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent
      ),
      child:  TextFormField(
        enabled: isEnabled,
        onTap: ontap,
        obscureText: isObscure,
        obscuringCharacter: '*',
        scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor:isEnabled?Colors.white: Color(0xFFe8e8e8),
            filled: true,
            labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
            border:  OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:addNewTextFieldFocusBorder)
            ),
            labelText: labelText,
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,

        onChanged: (v){
          onChange!(v);
        },
        onEditingComplete: (){

          onEditComplete!();
        },
      ),

    );
  }

  getType(){
    return 'inputTextField';
  }

  getValue(){
    return textEditingController.text;
  }

  setValue(var value){
    textEditingController.text=value.toString();
  }

  String getDataName(){
    return this.dataname;
  }

  void clearValues(){
    this.textEditingController.text="";
  }

  validate(){
    requiredCheck();
    return isValid.value;
  }


requiredCheck(){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Required";
  }
  else{
    isValid.value=true;
  }
  // return isValid.value;
}

minLengthCheck(dynamic min){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Minimum Length is $min";
  }
  else if(textEditingController.text.length<int.parse(min.toString())){
    isValid.value=false;
    errorText.value="* Minimum Length is $min";

  }
  else{
    isValid.value=true;
  }
  //  return isValid.value;
}

maxLengthCheck(dynamic max){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Maximum Length is $max";
  }
  else if(textEditingController.text.length>int.parse(max.toString())){
    isValid.value=false;
    errorText.value="* Maximum Length is $max";

  }
  else{
    isValid.value=true;
  }
  // return isValid.value;
}
emailValidation(){

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern as String);
  if(textEditingController.text.isEmpty){
    isValid.value=true;
    return;
  }
  if (!regex.hasMatch(textEditingController.text)) {
    isValid.value=false;
    errorText.value='* Email format is invalid';
  }
  else {
    isValid.value=true;
  }
  // return isValid.value;
}
}

/*class TextFormFieldController extends StatelessWidget {
  Map map;
  late TextEditingController textEditingController;
  Widget? suffix;
  Widget? prefix;
  Map? utilMap;
  bool hasInput;
  bool required;
  TextFormFieldController({required this.map,this.utilMap,this.suffix,this.prefix,this.hasInput=true,this.required=false}){
    textEditingController= new TextEditingController();
    obscureText.value=map.containsKey('obscureText')?map['obscureText']:false;

    if(map.containsKey('addUtils')){
      map.addAll(utilMap!);
    }

    // if(map.containsKey('suffix')){
    //   suffix=getChild(map['suffix'],myCallback: myCallback);
    // }
    // if(map.containsKey('prefix')){
    //   prefix=getChild(map['prefix'],myCallback: myCallback);
    // }
    isUnderLineBorder=map.containsKey("isUnderLineBorder")?map['isUnderLineBorder']:false;
  }

  var isValid=true.obs;
  var obscureText=false.obs;
  var errorText="* Required".obs;
  bool isUnderLineBorder=false;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: map.containsKey("parentHeight")?map['parentHeight']:null,
      alignment: Alignment.centerLeft,
      margin: dynamicParserUtils.parseEdgeInsetsGeometry(map['margin']),
      // width: map.containsKey('width') ?double.parse(map['width'].toString())*SizeConfig.screenWidth!:SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FocusScope(
            child: Focus(
                onFocusChange: (focus){
                  if(focus && map.containsKey('clickEvent')){
                    // myCallback.ontap(map['clickEvent']);
                  }

                },
                child: Obx(
                      ()=>TextFormField(
                    controller: textEditingController,
                    style: map.containsKey('textStyle') ? parseTextStyle(map['textStyle'])  : null,
                    scrollPadding: EdgeInsets.only(bottom: 100),
                    obscureText: obscureText.value,
                    obscuringCharacter: '*',
                    readOnly: map.containsKey('readOnly')?map['readOnly']:false,

                    // onTap: map.containsKey('clickEvent')?(){
                    //   // ontap.ontap(map['eventName']);
                    //   myCallback.ontap(map['clickEvent']);
                    // }:null,
                    decoration: InputDecoration(
                      hintText: map['hintText'],
                      hintStyle: map.containsKey('hintTextStyle') ? parseTextStyle(map['hintTextStyle'],) : null,
                      labelText: map['labelText'],
                      labelStyle: map.containsKey('labelStyle') ? parseTextStyle(map['labelStyle']) : null,
                      enabled: map.containsKey('enable')?map['enable']:true,
                      floatingLabelStyle: map.containsKey('floatingLabelStyle') ? parseTextStyle(map['floatingLabelStyle']) : null,
                      filled: true,
                      fillColor: map.containsKey('enable')?map['enable']?parseHexColor(map['color']):parseHexColor(map['disableColor']):parseHexColor(map['color'],),
                      border: isUnderLineBorder? UnderlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'])!
                          )
                      ):OutlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'])!
                          )
                      ),
                      enabledBorder:isUnderLineBorder? UnderlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'])!
                          )
                      ): OutlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['borderColor'])!
                          )
                      ),
                      focusedBorder: isUnderLineBorder? UnderlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['focusedBorderColor'])!
                          )
                      ):OutlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['focusedBorderColor'])!
                          )
                      ),
                      disabledBorder:isUnderLineBorder? UnderlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['disabledBorderColor'])!
                          )
                      ): OutlineInputBorder(
                          borderRadius: dynamicParserUtils.parseBorderRadius(map['borderRadius']),
                          borderSide: BorderSide(
                              color: parseHexColor(map['disabledBorderColor'])!
                          )
                      ),
                      contentPadding: EdgeInsets.only(top: map['topContentPadding']??0, left: map['leftContentPadding']??10.0),
                      suffixIcon: suffix,
                      prefixIcon: prefix,
                      suffixIconConstraints: BoxConstraints(
                          minWidth: 30.0
                      ),

                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(map.containsKey('textLength')?int.parse(map['textLength'].toString()):null),
                      FilteringTextInputFormatter.allow(RegExp(map.containsKey('regExp')?map['regExp']:'[A-Za-z0-9@., ]')),
                    ],
                    keyboardType: dynamicParserUtils.parseTextInputType(map['textInputType']),
                    onChanged: (v){
                      // myCallback.onTextChanged(v,map);
                    },
                    maxLines: map.containsKey("maxLines")?map['maxLines']:1,
                  ),
                )
            ),
          ),
          Obx(
                  ()=>isValid.value?Container():Container(
                  margin: dynamicParserUtils.parseEdgeInsetsGeometry(map['errorTextMargin']),
                  child: Text(errorText.value,style: map.containsKey('errorTextStyle') ? parseTextStyle(map['errorTextStyle']) : null,)
              )
          ),
        ],
      ),
    );
  }


  validate(){
    if(map.containsKey('groupValidation')){
      for(int i=0;i<map['groupValidation'].length;i++){
        // print(element.map['groupValidation'][i]);
        map['groupValidation'][i].forEach((key, value) {
          if(key=='Required'){
            requiredCheck();
          }
          else if(key=='MinimumLength'){
            minLengthCheck(value);
          }
          else if(key=='MaximumLength'){
            maxLengthCheck(value);

          }
          else if(key=='EmailValidation'){
            emailValidation();
          }
          else if(key=='CompareTo'){

            *//*if(element.map['groupValidation'][i].length>1){
              isValid=element.compareTo(widgets,element.map['groupValidation'][i]);
              validList.add(isValid);
            }*//*
          }
        });
        if(isValid.value){
          continue;
        }
        else{
          break;
        }
      }
    }
    else{
      requiredCheck();
    }

    return isValid.value;
  }


  requiredCheck(){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Required";
    }
    else{
      isValid.value=true;
    }
   // return isValid.value;
  }

  minLengthCheck(dynamic min){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";
    }
    else if(textEditingController.text.length<int.parse(min.toString())){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";

    }
    else{
      isValid.value=true;
    }
  //  return isValid.value;
  }

  maxLengthCheck(dynamic max){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";
    }
    else if(textEditingController.text.length>int.parse(max.toString())){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";

    }
    else{
      isValid.value=true;
    }
   // return isValid.value;
  }
  emailValidation(){

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    if(textEditingController.text.isEmpty){
      isValid.value=true;
      return;
    }
    if (!regex.hasMatch(textEditingController.text)) {
      isValid.value=false;
      errorText.value='* Email format is invalid';
    }
    else {
      isValid.value=true;
    }
   // return isValid.value;
  }


  compareTo(List widgets,dynamic value){
   *//* findWidgetByKey(widgets, {"key":value['CompareTo']}, (wid){
      print("Found  $wid ${wid.getValue()}");
      String getval=wid.getValue();
      if(getval == textEditingController.text){
        errorText.value="";
        isValid.value= true;
      }
      else{
        errorText.value=value['ErrorText'];
        isValid.value= false;
      }
    });*//*
    return isValid.value;
  }


  getValue(){
    return textEditingController.text;
  }


  getType() {
    return 'inputTextField';
  }
  setValue(var val){
    textEditingController.text=val;
  }
}*/



















//Json Parsing Functions

TextStyle? parseTextStyle(var textStyle) {
  var map=textStyle;
  if (map == null) {
    return null;
  }
  // else if(textStyle.runtimeType== String){
  //   map=myCallback.getWidgetMapFromTemplate(textStyle);
  // }

  //TODO: more properties need to be implemented, such as decorationColor, decorationStyle, wordSpacing and so on.
  String? color = map['color'];
  String? debugLabel = map['debugLabel'];
  String? decoration = map['decoration'];
  String? decorationColor = map['decorationColor'];
  String? shadowColor = map['shadowColor'];
  String? fontFamily = map['fontFamily'];
  double? fontSize = map['fontSize']?.toDouble();
  String? fontWeight = map['fontWeight'];
  FontStyle fontStyle =
  'italic' == map['fontStyle'] ? FontStyle.italic : FontStyle.normal;

  return TextStyle(
    color: parseHexColor(color),
    debugLabel: debugLabel,
    decoration: parseTextDecoration(decoration),
    decorationColor: parseHexColor(decorationColor),
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    shadows:map.containsKey('shadowColor')? [
      Shadow(
          color: parseHexColor(shadowColor)!,
          offset: Offset(0, map['offsetDy'])
      )
    ]:null,
    //   fontWeight: parseFontWeight(fontWeight),
  );
}
Color? parseHexColor(String? hexColorString) {
  if (hexColorString == null) {
    return Colors.transparent;
  }
  if(hexColorString.contains("*")){
    //return myCallback.ontap({"eventName":"parseColor","color":hexColorString});
    return Colors.transparent;
  }
  else{
    hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
    if(hexColorString=='red'.toUpperCase()){
      return Colors.red;
    }
    else if(hexColorString=='green'.toUpperCase()){
      return Colors.green;
    }
    else if(hexColorString=='transparent'.toUpperCase()){
      return Colors.transparent;
    }
    else if(hexColorString=='hide'.toUpperCase()){
      return null;
    }
    else{
      if (hexColorString.length == 6) {
        hexColorString = "FF" + hexColorString;
      }
      int colorInt = int.parse(hexColorString, radix: 16);
      return Color(colorInt);
    }
  }
}
TextDecoration parseTextDecoration(String? textDecorationString) {
  TextDecoration textDecoration = TextDecoration.none;
  switch (textDecorationString) {
    case "lineThrough":
      textDecoration = TextDecoration.lineThrough;
      break;
    case "overline":
      textDecoration = TextDecoration.overline;
      break;
    case "underline":
      textDecoration = TextDecoration.underline;
      break;
    case "none":
    default:
      textDecoration = TextDecoration.none;
  }
  return textDecoration;
}
