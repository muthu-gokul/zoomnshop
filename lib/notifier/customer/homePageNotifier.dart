import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoomnshop/notifier/configuration.dart';
import '../../styles/constants.dart';
import '../../widgets/calculation.dart';
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../constants/sp.dart';
import '../../model/parameterMode.dart';
import '../../pages/customer/OrderSuccess.dart';

var homePageController=Get.put(HomePageNotifier());
class HomePageNotifier extends GetxController{
  RxList<dynamic> industryList=RxList();
  RxList<dynamic> filterShopList=RxList();
  RxList<dynamic> filterCategoryList=RxList();
  RxList<dynamic> filterProductList=RxList();
  var selectedIndustryIndex=0.obs;
  var selectedShopIndex=0.obs;
  var selectedCategoryIndex=0.obs;
  var selectedProductIndex=0.obs;

  void getHomePageDetail() async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.getHomePageDetail));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        industryList.value=parsed['Table'];
        setSharedPrefList("ShopList", parsed['Table1']);
        setSharedPrefList("CategoryList", parsed['Table2']);
        setSharedPrefList("ProductList", parsed['Table3']);
        if(industryList.isNotEmpty){
          selectedIndustryIndex.value=0;
          filterShop();
        }
        else{
          filterShopList.clear();
          selectedIndustryIndex.value=-1;
        }


        log("HomePageNotifier $parsed");
      }
    });
  }


  void filterShop() async{
    selectedShopIndex.value=-1;
    if(selectedIndustryIndex.value>=0){
      List shopList=await getSharedPrefList("ShopList");
      filterShopList.value=shopList.where((element) => element['IndustryCategoryId']==industryList[selectedIndustryIndex.value]['IndustryCategoryId']).toList();
      if(filterShopList.isNotEmpty){
        selectedShopIndex.value=0;
      }
    }
    else{
      filterShopList.clear();
    }
    filterCategory();
  }

  void filterCategory() async{
    selectedCategoryIndex.value=-1;
    if(selectedShopIndex.value>=0){
      List shopList=await getSharedPrefList("CategoryList");
      filterCategoryList.value=shopList.where((element) => element['ClientId']==filterShopList[selectedShopIndex.value]['ClientId']).toList();
      if(filterCategoryList.isNotEmpty){
        selectedCategoryIndex.value=0;
      }
    }
    else{
      filterCategoryList.clear();
    }
    filterProduct();
  }

  void filterProduct() async{
    selectedProductIndex.value=-1;
    if(selectedCategoryIndex.value>=0){
      List shopList=await getSharedPrefList("ProductList");
      filterProductList.value=shopList.where((element) => element['ProductCategoryId']==filterCategoryList[selectedCategoryIndex.value]['ProductCategoryId']).toList();
    }
    else{
      filterProductList.clear();
    }
  }
}
