import 'package:get/get.dart';
import 'package:zoomnshop/pages/shopKeeper/shopKeeperHomeScreen.dart';

import '../pages/customer/navHomeScreen.dart';
import '../widgets/alertDialog.dart';
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