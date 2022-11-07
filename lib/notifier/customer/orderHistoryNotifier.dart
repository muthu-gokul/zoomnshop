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

var orderHistoryController=Get.put(OrderHistoryNotifier());
class OrderHistoryNotifier extends GetxController{
  RxList<dynamic> orderHistoryList=RxList<dynamic>();
  RxList<dynamic> orderHistoryProductList=RxList<dynamic>();
  var totalQty=0.0.obs;
  void getOrderHistory() async{

    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getOrderHistory));
    params.add(ParameterModel(Key: "OrdersId", Type: "String", Value: null));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        orderHistoryList.value=parsed['Table'];
        log("$parsed");
      }
    });
  }

  void getOrderHistoryById(orderId) async{

    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getOrderHistory));
    params.add(ParameterModel(Key: "OrdersId", Type: "String", Value: orderId));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        orderHistoryProductList.value=parsed['Table'];
        log("$parsed");
        qtyCalc();
      }
    });
  }
  void qtyCalc(){
    totalQty.value=0.0;
    orderHistoryProductList.value.forEach((element) {
      totalQty.value=Calculation().add(totalQty.value, element['Quantity']);
    });
  }
  void clearData(){
    orderHistoryList.clear();
    orderHistoryProductList.clear();
  }
}