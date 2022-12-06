import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:zoomnshop/api/ApiManager.dart';
import 'package:zoomnshop/widgets/alertDialog.dart';

void hs256() {
  String token;

  /* Sign */ {
    // Create a json web token
    final jwt = JWT(
      {
        'id': 123,
        'server': {
          'id': '3e4fc296',
          'loc': 'euw-2',
        }
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    // Sign it
    token = jwt.sign(SecretKey('secret passphrase'));

    print('Signed token: $token\n');
  }

  /* Verify */ {
    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey('secret passphrase'));

      print('Payload: ${jwt.payload}');
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }
}

String appAccessKey="634400644208780bf665757d";
String app_secret="sj6-fBZElEnvG6V-w99ZGAkQPKDLK93QJBtOf6kXNwbwCsdluMmP36SN106BslR8uNhiPM-jz3BNJO8oOA2fDSkFW0eocFqa4IGRBFQU6v4_wVQlU0uwDqtkPSSL-OfGyzFpbLXemdYwHnqaGu0kgNFdW4Ur4oAeqSxRyf3plTk=";
Future<dynamic> generateManagementToken() async {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String mToken=await sharedPreferences.getString("managementToken")??"";
  var proceed=false;
  if(mToken.isEmpty){
    proceed=true;
  }
  else{
    proceed=!verifyJWT(mToken);
  }
  //if(verifyJWT(mToken)){
  if(!proceed){
    return "Valid Token";
  }
  print("generateManagementToken");
  String token;
    final jwt = JWT(
      {
        'access_key':appAccessKey,
        'type': "management",
        'version': 2,
        'jti':Uuid().v1()
      }
    );
    // Sign it
    token = jwt.sign(SecretKey(app_secret),expiresIn: Duration(milliseconds: DateTime.now().millisecond+86400 * 1000),
    notBefore: Duration(milliseconds: DateTime.now().millisecond));
    sharedPreferences.setString("managementToken", token);
    return token;
}
bool verifyJWT(token){
  try {
    // Verify a token
    final jwt = JWT.verify(token, SecretKey(app_secret));
    return true;
    print('Payload: ${jwt.payload}');
  } on JWTExpiredError {
    print('jwt expired');
    return false;
  } on JWTError catch (ex) {
    return false;
    print(ex.message); // ex: invalid signature
  }
}

Future<dynamic> createRoomFromApi(name) async{
  try{
    showLoader.value=true;
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String mToken=await sharedPreferences.getString("managementToken")??"";
    //print(mToken);
    http.Response response = await http.post(Uri.parse("https://api.100ms.live/v2/rooms"), body: json.encode({
      'name': name
    }), headers: {
      'Authorization': 'Bearer $mToken',
      'Content-Type': 'application/json'
    });
    showLoader.value=false;
    if(response.statusCode==200){
      var body = json.decode(response.body);
      return body;
    }
    else{
      return null;
    }
  }catch(e,t){

    CustomAlert().commonErrorAlert("$e", "$t");
  }
}