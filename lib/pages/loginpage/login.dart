import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoomnshop/pages/loginpage/OtpGenerat.dart';

import '../../styles/constants.dart';
import '../../styles/style.dart';
import '../../utils/sizeLocal.dart';
import '../navHomeScreen.dart';
import 'EnterEmail.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> with SingleTickerProviderStateMixin{
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
  int _current = 0;
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    passwordvisible = true;
    loginvalidation=false;
    shakecontroller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    username.clear();
    password.clear();
    // SharedPreferences.getInstance()
    //   ..then((prefs) {
    //     setState(() => this._Loginprefs = prefs);
    //
    //     _loadCredentials();
    //   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    node=FocusScope.of(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);

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
          body: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding:EdgeInsets.only(top:20 ) ,
                          child: Image.asset('assets/images/loginpages/Homelogin.png', width:SizeConfig.screenWidth!*0.9,fit: BoxFit.cover,),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          alignment: AlignmentDirectional.center,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  child: Text('Welcom to',style: TextStyle(fontSize: 16,fontFamily: 'RB',color: Color(0XFF000000)),)
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  child: Text('Zoom N Shop',style: TextStyle(fontSize: 20,fontFamily: 'RB',color: Color(0XFFFE316C)),)
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
                                              height: 60,
                                              width:SizeConfig.screenWidth!*0.85,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border:loginvalidation? Border.all(color: Colors.red,width: 2):Border.all(color: borderColor,width: 2),
                                                  color: loginvalidation?Color(0xFFCECECE):fillColor),
                                              child: TextFormField(
                                                scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                                style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:18,fontFamily: 'RR' ),
                                                controller: username,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  hintText: "User Name",
                                                  hintStyle: TextStyle(
                                                      color:loginvalidation?Colors.red: inputTextColor.withOpacity(0.7),fontSize: 18,fontFamily: 'RR'),
                                                  contentPadding: EdgeInsets.only(left: 20,top: 10),
                                                  //   fillColor: loginvalidation?HexColor("1C1F32"):Colors.white,

                                                ),
                                                keyboardType: TextInputType.emailAddress,
                                                validator:(value){

                                                  Pattern pattern =
                                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                  RegExp regex = new RegExp(pattern as String);
                                                  if (!regex.hasMatch(value!)) {
                                                    return 'Email format is invalid';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onEditingComplete: (){
                                                  node.nextFocus();
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Container(
                                              height: 60,
                                              width: SizeConfig.screenWidth!*0.85,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border:loginvalidation? Border.all(color: Colors.red,width: 2):Border.all(color: borderColor,width: 2),
                                                  color:loginvalidation?Color(0xFFCECECE): fillColor),
                                              child: TextFormField(
                                                scrollPadding: EdgeInsets.only(bottom:SizeConfig.height250!),
                                                style: TextStyle(color:loginvalidation?Colors.red:inputTextColor,fontSize:18,fontFamily: 'RR' ),
                                                controller: password,
                                                obscureText: passwordvisible,
                                                obscuringCharacter: '*',
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  hintText: "Password",
                                                  hintStyle:TextStyle(color:loginvalidation?Colors.red:inputTextColor.withOpacity(0.7),fontSize:18,fontFamily: 'RR' ),
                                                  contentPadding: EdgeInsets.only(left: 20, top: 20),
                                                  // suffixIconConstraints: BoxConstraints(
                                                  //     minHeight: 55,
                                                  //     maxWidth: 55
                                                  // ),
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
                                                    return 'Password is required';
                                                  }
                                                },
                                                onEditingComplete: () async {
                                                  node.unfocus();
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Container(
                                              alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpGenerat()),);

                                                        },
                                                        child: Text('Login with OTP',style: TextStyle(fontSize: 18,fontFamily: 'RB',color: Color(0XFFFE316C)),)),
                                                  ],
                                                )
                                            ),
                                            SizedBox(height: 20,),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Masterpage()),);
                                                /*if(_loginFormKey.currentState!.validate()){

                                                }*/
                                              },
                                              child: Container(
                                                height: 60,
                                                width: SizeConfig.screenWidth!*0.85,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
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
        ),
    );
  }
}
