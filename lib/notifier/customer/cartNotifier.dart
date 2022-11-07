import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../styles/constants.dart';
import '../../widgets/calculation.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../pages/customer/OrderSuccess.dart';

var cartController=Get.put(CartNotifier());
class CartNotifier extends GetxController{
  RxList<dynamic> cartAppList=RxList<dynamic>();
  RxList<dynamic> cartProductList=RxList<dynamic>();
  var totalQty=0.0.obs;

  var appoId=-1,clientOutletId=-1;

  void getCartApp() async{

    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getAppCart));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: null));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        cartAppList.value=parsed['Table'];
        log("$parsed");
      }
    });
  }
  void getCartDetail(appId,clientOutId) async{
    totalQty.value=0.0;
    appoId=appId;
    clientOutletId=clientOutId;
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getAppCart));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: appId));
    print(jsonEncode(params));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        cartProductList.value=parsed['Table'];
        log("$parsed");
        qtyCalc();
      }
    });
  }
  void qtyCalc(){
    cartProductList.value.forEach((element) {
      totalQty.value=Calculation().add(totalQty.value, element['Quantity']);
    });
  }

  void insertOrderDetail() async{

    List<dynamic> OrdersProductMappingList=[];
    cartProductList.forEach((element) {
      OrdersProductMappingList.add({
        'OrdersProductMappingId':null,
        'OrdersId':null,
        'ProductId':element['ProductId'],
        'Quantity':element['Quantity'],
        'IsActive':true,
      });
    });
    log(jsonEncode(OrdersProductMappingList));


    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertOrderDetail));
    params.add(ParameterModel(Key: "AppointmentId", Type: "String", Value: appoId));
    params.add(ParameterModel(Key: "ClientOutletId", Type: "String", Value: clientOutletId));
    params.add(ParameterModel(Key: "OrderDate", Type: "String", Value: DateFormat(dbDateFormat).format(DateTime.now())));
    params.add(ParameterModel(Key: "OrdersProductMappingList", Type: "datatable", Value: jsonEncode(OrdersProductMappingList)));

    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("$parsed");
        cartProductList.clear();
        Get.back();
        Get.to(OrderSuccessful())!.then((value){
          getCartApp();
        });
      }
    });
  }


  void clearData(){
    cartProductList.clear();
    cartAppList.clear();
  }

}
