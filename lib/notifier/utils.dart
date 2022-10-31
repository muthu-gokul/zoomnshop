import 'package:get/get.dart';

import '../pages/navHomeScreen.dart';
import '../widgets/alertDialog.dart';
import 'configuration.dart';

void navigateByUserType() async{
  String usertype=await getSharedPrefString(SP_USERTYPEID);
  if(usertype==UserType.customer.index.toString()){
    Get.off(const CustomerHomeScreen());
  }
  else{
    CustomAlert().commonErrorAlert("Invalid User", "");
  }
}