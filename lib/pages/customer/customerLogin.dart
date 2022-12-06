import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/ApiManager.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../notifier/netConnectivityNotifier.dart';
import '../../styles/constants.dart';
import '../../utils/colorUtil.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/loader.dart';
import '../../widgets/validationErrorText.dart';
import '../settings/pinScreenSettings.dart';

class CutomerLogin extends StatefulWidget {
  const CutomerLogin({Key? key}) : super(key: key);

  @override
  State<CutomerLogin> createState() => _CutomerLoginState();
}

class _CutomerLoginState extends State<CutomerLogin>  with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  late bool passwordvisible;
  late bool loginvalidation;
  late AnimationController shakecontroller;
  late Animation<double> offsetAnimation;
  bool isLoading=false;
  bool isVisible=false;
  bool? rememberMe=false;

  String? prefEmail;
  String? prefPassword;
  bool? prefRememberMe;
  // late SharedPreferences _Loginprefs;
  static const String useremail = 'email';
  static const String passwordd = 'password';
  static const String rememberMee = 'rememberMe';
  late var node;
  Color fillColor=Color(0xFFFFFFFF);
  Color borderColor=Color(0xFFE5E5E5);
  Color inputTextColor=Color(0xFF9b9b9b);
  BorderRadius borderRadius=BorderRadius.circular(10);

  var emailInValid=false.obs;
  var passwordInValid=false.obs;

  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    passwordvisible = true;
    loginvalidation=false;
    shakecontroller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    username.clear();
    password.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    node=FocusScope.of(context);
    offsetAnimation = Tween(begin: 0.0, end: 28.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(shakecontroller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakecontroller.reverse().whenComplete(() {
            setState(() {
              loginvalidation=false;
            });
          });
        }
      });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF7F8FA),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding:EdgeInsets.only(top:20 ) ,
                      child: Image.asset('assets/images/loginpages/Homelogin.png', width:SizeConfig.screenWidth!*0.9,height: SizeConfig.screenHeight!*0.4,fit: BoxFit.cover,),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Text('Welcome to',style: TextStyle(fontSize: 16,fontFamily: 'RB',color: Color(0XFF000000)),)
                          ),
                          SizedBox(height: 10,),
                          Container(
                              child: Text('Zoom & Shop',style: TextStyle(fontSize: 20,fontFamily: 'RB',color: Color(0XFFFE316C)),)
                          ),
                        ],
                      ) ,
                    ),
                    Container(
                      child:  Form(
                          key: _loginFormKey,
                          child: AnimatedBuilder(
                              animation: offsetAnimation,
                              builder: (context, child) {
                                return Container(
                                  //  margin: EdgeInsets.symmetric(horizontal: 24.0),
                                  padding: EdgeInsets.only(left: offsetAnimation.value + 15.0, right: 15.0 - offsetAnimation.value),
                                  child: Container(
                                    // margin: EdgeInsets.only(top: _height * 0.28),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        loginvalidation?Text("Invalid Email Or Password",
                                          style: TextStyle(color: Colors.red,fontSize: 18,fontFamily: 'RR',letterSpacing: 0.2),
                                        ):Container(height: 20,width: 0,),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 50,
                                          width:SizeConfig.screenWidth!*0.8,
                                          /*decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:loginvalidation? Border.all(color: Colors.red,width: 2):Border.all(color: borderColor,width: 2),
                                              color: loginvalidation?Color(0xFFCECECE):fillColor),*/
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                            style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:15,fontFamily: 'RR' ),
                                            controller: username,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:borderColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:borderColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:ColorUtil.primaryColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              errorBorder: InputBorder.none,
                                              hintText: "User Name",
                                              hintStyle: TextStyle(color:loginvalidation?Colors.red: inputTextColor.withOpacity(0.7),fontSize: 15,fontFamily: 'RR'),
                                              contentPadding: EdgeInsets.only(left: 20,top: 0),
                                              //   fillColor: loginvalidation?HexColor("1C1F32"):Colors.white,
                                              fillColor: Colors.white,
                                              filled: true,
                                              errorStyle: TextStyle(fontSize: 0),
                                            ),
                                            keyboardType: TextInputType.emailAddress,
                                            validator:(value){

                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex = new RegExp(pattern as String);
                                              if (!regex.hasMatch(value!)) {
                                                emailInValid.value=true;
                                                return 'Email format is invalid';
                                              } else {
                                                emailInValid.value=false;
                                                return null;
                                              }
                                            },
                                            onEditingComplete: (){
                                              node.nextFocus();
                                            },
                                          ),
                                        ),
                                        Obx(() => Visibility(visible:emailInValid.value,child: ValidationErrorText(title: "* Email format is invalid",leftPadding: 20))),
                                        SizedBox(height: 20,),
                                        Container(
                                          height: 50,
                                          width: SizeConfig.screenWidth!*0.8,
                                          child: TextFormField(
                                            scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                            style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:15,fontFamily: 'RR' ),
                                            controller: password,
                                            obscureText: passwordvisible,
                                            obscuringCharacter: '*',
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(fontSize: 0),
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:borderColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:borderColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color:loginvalidation?Colors.red:ColorUtil.primaryColor ,width: 1),
                                                borderRadius: borderRadius,
                                              ),
                                              errorBorder: InputBorder.none,
                                              hintText: "Password",
                                              hintStyle:TextStyle(color:loginvalidation?Colors.red:inputTextColor.withOpacity(0.7),fontSize:15,fontFamily: 'RR' ),
                                              contentPadding: EdgeInsets.only(left: 20, top: 14),
                                              suffixIcon: Padding(
                                                padding:  EdgeInsets.only(right: 10,top: 3),
                                                child: IconButton(icon: Icon(passwordvisible?Icons.visibility_off:Icons.visibility,size: 30,color: Colors.grey,),
                                                    onPressed: (){
                                                      setState(() {
                                                        passwordvisible=!passwordvisible;
                                                      });
                                                    }),
                                              ),
                                            ),
                                            keyboardType: TextInputType.emailAddress,
                                            validator:(value){
                                              if(value!.isEmpty){
                                                passwordInValid.value=true;
                                                return 'Password is required';
                                              }
                                              else{
                                                passwordInValid.value=false;
                                              }
                                            },
                                            onEditingComplete: () async {
                                              node.unfocus();
                                            },
                                          ),
                                        ),
                                        Obx(() => Visibility(visible:passwordInValid.value,child: ValidationErrorText(title: "* Password is required",leftPadding: 20,))),
                                        SizedBox(height: 20,),
                                        Container(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                    onTap: (){
                                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpGenerat()),);

                                                    },
                                                    child: Text('Login with OTP',style: TextStyle(fontSize: 18,fontFamily: 'RB',color: Color(0XFFFE316C)),)),
                                              ],
                                            )
                                        ),
                                        SizedBox(height: 20,),
                                        GestureDetector(
                                          onTap: (){
                                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                                            login();
                                          },
                                          child: Container(
                                            height: 50,
                                            width: SizeConfig.screenWidth!*0.8,
                                            decoration: BoxDecoration(
                                              borderRadius: borderRadius,
                                              color: Color(0XFFFE316C),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text("Login",style: whiteRM20,),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
            Loader(value: isLoading,)
          ],
        ),
      ),
    );
  }

  login() async{
    setState(() {
      isLoading=true;
    });
    node.unfocus();
    //var loginNotifier=Provider.of<LoginNotifier>(context, listen: false);
    var inn=Provider.of<InternetNotifier>(context, listen: false);
    if(_loginFormKey.currentState!.validate()){
      try{
        if(inn.isOnline){
          List<ParameterModel> params=[];
          params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.loginSp));
          params.add(ParameterModel(Key: "UserName", Type: "String", Value: username.text));
          params.add(ParameterModel(Key: "Password", Type: "String", Value: password.text));
          params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
          params.add(ParameterModel(Key: "Type", Type: "String", Value: 1));
          params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: null));
          params.add(ParameterModel(Key: "OTPNumber", Type: "String", Value: null));
          ApiManager().GetInvokeLogin(params).then((response){
            if(response[0]){
              setState(() {
                isLoading=false;
              });
              var parsed=json.decode(response[1]);
              log("$parsed");
              /*
              return;*/
              var t =parsed['Table'];
              if(t.length>0){
                log("login $t");
                if(t[0]['UserTypeId']==2){
                  setSharedPrefString(t[0]['LoginUserId'], SP_USER_ID);
                  setSharedPrefString(t[0]['UserPINNumber'], SP_PIN);
                  setSharedPrefString(t[0]['UserTypeId'], SP_USERTYPEID);
                  setSharedPrefString(t[0]['Fullname'], SP_USERNAME);
                  setSharedPrefString(username.text, SP_USEREMAIL);
                  setSharedPrefString(password.text, SP_USERPASSWORD);
                  Get.off(PinScreenSettings(fromLogin: true,));
                }
                else if(t[0]['UserTypeId']==1){
                  setSharedPrefString(t[0]['LoginUserId'], SP_USER_ID);
                  setSharedPrefString(t[0]['UserPINNumber'], SP_PIN);
                  setSharedPrefString(t[0]['UserTypeId'], SP_USERTYPEID);
                  setSharedPrefString(t[0]['Fullname'], SP_USERNAME);
                  setSharedPrefString(t[0]['CompanyId'], SP_COMPANYID);
                  setSharedPrefString(username.text, SP_USEREMAIL);
                  setSharedPrefString(password.text, SP_USERPASSWORD);
                  Get.off(PinScreenSettings(fromLogin: true,));
                }
                else{
                  CustomAlert().commonErrorAlert("Access Denied", "");
                }
              }

            }
            else{
              setState(() {
                isLoading=false;
              });
            }
          });
        }
        else{
          setState(() {
            isLoading=false;
          });
          CustomAlert().commonErrorAlert( "No Internet"," ");
        }
      }
      catch(e){
        setState(() {
          isLoading=false;
        });
        CustomAlert().commonErrorAlert( "$e"," ");
      }

    }
    else{
      setState(() {
        isLoading=false;
      });
    }
  }
}
