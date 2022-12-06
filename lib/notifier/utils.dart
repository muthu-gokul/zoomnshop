import 'package:get/get.dart';
import 'package:zoomnshop/pages/shopKeeper/shopKeeperHomeScreen.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../constants/sp.dart';
import '../model/parameterMode.dart';
import '../pages/customer/navHomeScreen.dart';
import '../widgets/alertDialog.dart';
import 'callNotifier.dart';
import 'configuration.dart';

//1 shop keeper
//2 customer
//3 admin
int APPTYPE=2;

void navigateByUserType() async{
  String usertype=await getSharedPrefString(SP_USERTYPEID);
  if(usertype==UserType.customer.index.toString()){
    Get.off(const CustomerHomeScreen());
  }
  else if(usertype==UserType.shopKeeper.index.toString()){
    Get.off(ShopKeeperHomeScreen());
  }
  else{
    CustomAlert().commonErrorAlert("Invalid User", "");
  }
}


Future<String> getUserRoleForCall() async{
  String userType=await getSharedPrefString(SP_USERTYPEID);
  if(userType==UserType.customer.index.toString()){
    return 'customer';
  }
  else if(userType==UserType.shopKeeper.index.toString()){
    return 'shopkeeper';
  }
  else{
    return '';
  }
}

String getAppoiStatusByIndex(int i){
  switch(i){
    case 0:return 'UpComing';
    case 1:return 'Completed';
    case 2:return 'Cancelled';
    default:
      return 'UpComing';
  }
}

String getImgFileName(dynamic x){
  var arr=x.toString().split("/");
  if(arr.length==2){
    return arr[1];
  }
  else{
    return x;
  }
}

void onLogout(){
  setSharedPrefString("", SP_PIN);
  setSharedPrefString("", SP_COMPANYID);
  setSharedPrefString("", SP_USER_ID);
  setSharedPrefString("", SP_USEREMAIL);
  setSharedPrefString("", SP_USERPASSWORD);
  setSharedPrefString("", SP_USERTYPEID);
}

void updateNotificationId(ft) async{
  String ft=await getSharedPrefString(SP_FIREBASETOKEN);
  if(await getLoginId()==""){
    return;
  }
  List<ParameterModel> params=await getParameterEssential();
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.updateNotificationId));
  params.add(ParameterModel(Key: "DeviceInfo", Type: "String", Value: deviceData.toString()));
  params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
  params.add(ParameterModel(Key: "NotificationTokenNumber", Type: "String", Value: ft));
  //log("insertDeviceInfo ${jsonEncode(params)}");
  ApiManager().GetInvoke(params).then((response) async {
    if(response[0]){

    }
  });
}

void checkNotiPurpose(Map data){
  if(data["notificationPurpose"]=="Call"){
    callPurpose(data);
  }
}

void callPurpose(Map data){
  initiateCallFromNoti(data);
}