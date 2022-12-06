import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../app_theme.dart';
import '../../styles/constants.dart';

import '../../utils/sizeLocal.dart';
import 'dropdown_search.dart';




class Search2 extends StatelessWidget {
  VoidCallback? scrollTap;
  double? width;
  double dialogWidth;
  //String selectedValue;
  List<dynamic>? data;
  Function(int)? onitemTap;
  Function(dynamic)? selectedValueFunc;
  bool? isToJson;
  String propertyName;
  String propertyId;
  String? hinttext;
  bool isEnable;
  BoxDecoration? selectWidgetBoxDecoration;
  EdgeInsets? margin;
  EdgeInsets? dialogMargin;
  bool showSearch;
  var selectedValue;
  double selectWidgetHeight;
  String dataName;
  bool hasInput;
  bool required;
  Mode mode;
  double maxHeight;

  Search2({ this.width,this.selectedValueFunc,
    this.data, this.onitemTap, this.isToJson,this.propertyName="Text",this.propertyId="Id", this.hinttext,
    this.isEnable=true, this.scrollTap,this.margin,this.dialogMargin,this.selectWidgetHeight=70.0,
    this.selectWidgetBoxDecoration,this.showSearch=true,this.selectedValue=const {},required this.dialogWidth,
    required this.dataName,this.hasInput=true,this.required=false,this.mode=Mode.MENU,this.maxHeight=400.0}){
    if(this.selectedValue.isNotEmpty){
      selectedData.value=selectedValue;
    }
    if(this.data!=null ){
      if(this.data!.isNotEmpty){
        dataNotifier.value=data!;
      }
    }
  }

  FocusNode f4 = FocusNode();
  // final ValueNotifier<List<dynamic>> dataNotifier = ValueNotifier([]);
  var dataNotifier=[].obs;
  var selectedData={}.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: DropdownSearch<String>(

        popupBackgroundColor: Colors.white,
        dropdownSearchDecoration: InputDecoration(),
        mode: mode,
        showSelectedItems: false,
        popupElevation: 2,
        showClearButton: false,
        showSearchBox: false,
        dropDownButton: Icon(Icons.eleven_mp),
        searchDelay: Duration(milliseconds: 0),

        ontap: (){
          scrollTap!();
          dataNotifier.value=data!;
        },
        selectWidget: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          height: selectWidgetHeight,
          width: width,
          margin:margin==null? EdgeInsets.only(left:SizeConfig.width100!,right:SizeConfig.width100!,top:20):margin,
          decoration:selectWidgetBoxDecoration?? BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color:Color(0xFFCDCDCD)),
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Obx(
                    ()=>Text("${selectedData.isEmpty? hinttext!: isToJson!?selectedData[propertyName]??hinttext:selectedData['value']}",
                  style: TextStyle(color:selectedData.isEmpty? addNewTextFieldText.withOpacity(0.8):addNewTextFieldText,fontSize: 15,fontFamily: 'RR'),
                ),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.grey,),
              SizedBox(width: 15,)
            ],
          ),
        ),
        dialogWidget: Obx(
            ()=>Container(
              height:dataNotifier.isEmpty?150:  (data!.length*50.0)+100,
              width: dialogWidth,
              margin:dialogMargin==null? EdgeInsets.only(left:SizeConfig.width100!,right:SizeConfig.width100!,top:5):dialogMargin,
              //padding: EdgeInsets.only(top: 10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(0,0)
                    )
                  ]
              ),
              constraints: BoxConstraints(
                  maxHeight: maxHeight
              ),
              child: Column(
                children: [
                  !showSearch?Container():Container(
                    height: 50,
                    width: width,
                    margin: EdgeInsets.fromLTRB(15,15,15,0),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      //    style: textFormTs1,
                      focusNode: f4,
                     //scrollPadding: EdgeInsets.only(bottom: 200),
                      decoration: InputDecoration(
                          hintText: "Search",
                          // hintStyle: textFormHintTs1,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 25.0)
                      ),
                      onEditingComplete: (){
                        f4.unfocus();
                      },
                      onChanged: (v){
                        dataNotifier.value=data!.where((element) => element.toString().toLowerCase().contains(v.toLowerCase())).toList();
                      },
                    ),
                  ),
                  dataNotifier.isEmpty?Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("No Data Found",style: AppTheme.textFormStyle,),
                  ):
                  Flexible(child: ListView.builder(
                    itemCount: dataNotifier.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx,index){
                      return   InkWell(
                        onTap:(){
                          Navigator.pop(ctx);
                          onitemTap!(index);
                          selectedValueFunc!(dataNotifier[index]);
                          if(isToJson!)
                            selectedData.value=dataNotifier[index];
                          else
                            selectedData.value={"value":dataNotifier[index]};
                        },
                        child: Container(
                          height: 50,
                          width:width,
                          padding: EdgeInsets.only(left: 20,),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color:(isToJson!?"${dataNotifier[index][propertyId].toString()}":"${dataNotifier[index].toString()}" )== (isToJson!?selectedData[propertyId].toString():selectedData['value'])?AppTheme.restroTheme:Colors.white,
                          ),
                          child:  Text(isToJson!?"${dataNotifier[index][propertyName]}":"${dataNotifier[index]}",
                            style: TextStyle(fontFamily: 'RR',fontSize: 15,color:(isToJson!?"${dataNotifier[index][propertyId].toString()}":"${dataNotifier[index].toString()}" )== (isToJson!?selectedData[propertyId].toString():selectedData['value'].toString())?Colors.white: Colors.grey
                              // color:selectedValue==data![index]?Colors.white: Color(0xFF555555),letterSpacing: 0.1
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            )
        ),
        onChanged: (s){},
        clearButtonSplashRadius: 20,
        selectedItem:"",
        onBeforeChange: (a, b) {
          return Future.value(true);
        },
      ),
    );
  }
  getValue(){
    return isToJson!?selectedData[propertyId]:selectedData['value'];
  }
  getValueMap(){
    return selectedData;
  }
  setValues(Map value){
    selectedData.value=value;
    reload();
  }
  setDataArray(List dataList){
    data=dataList;
    dataNotifier.value=dataList;
    reload();
  }
  clearValues(){
    selectedData.value={};
  }
  void reload(){
    //return;
    if(selectedData.isNotEmpty && dataNotifier.isNotEmpty){
      try{
        var tempVal=dataNotifier.firstWhere((element) => element[propertyId].toString()==selectedData[propertyId].toString());
        selectedData.value=tempVal;
      }catch(e){}
      //_typeAheadController.text=tempVal['Text'];
    }
  }

  String getDataName(){
    return this.dataName;
  }
  getType(){
    return 'searchDrp';
  }
  validate(){
    return getValue()!=null || getValue()!='';
  }

}

class Search2MultiSelect extends StatelessWidget {
  String dataName;
  VoidCallback? scrollTap;
  double? width;
  //String selectedValue;
  List<dynamic>? data;
  Function(int)? onitemTap;
  Function(dynamic)? selectedValueFunc;
  bool? isToJson;
  String propertyName;
  String propertyId;
  String? hinttext;
  bool isEnable;
  BoxDecoration? selectWidgetBoxDecoration;
  EdgeInsets? margin;
  EdgeInsets? dialogMargin;
  bool showSearch;
  Function(String) doneCallback;
  bool hasInput;
  bool required;

  Search2MultiSelect({ this.width,this.selectedValueFunc,
    this.data, this.onitemTap, this.isToJson,this.propertyName="Text",this.propertyId="Id", this.hinttext,
    this.isEnable=true, this.scrollTap,this.margin,required this.dataName,this.hasInput=true,this.required=false,
    this.dialogMargin, this.selectWidgetBoxDecoration,this.showSearch=true,required this.doneCallback});

  FocusNode f4 = FocusNode();
 // final ValueNotifier<List<dynamic>> dataNotifier = ValueNotifier([]);
  var dataNotifier=[].obs;
  var selectedData=[].obs;
  var selectedText=[].obs;
  var checked=false.obs;

  double hei1=50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: DropdownSearch<String>(

        popupBackgroundColor: Colors.white,
        dropdownSearchDecoration: InputDecoration(),
        mode: Mode.MENU,
        showSelectedItems: false,
        popupElevation: 2,
        showClearButton: false,
        showSearchBox: false,
        dropDownButton: Icon(Icons.eleven_mp),
        searchDelay: Duration(milliseconds: 0),
        ontap: (){
          scrollTap!();
          dataNotifier.value=data!;
          checked.value=!checked.value;
        },
        selectWidget: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          height: hei1,
          width: width,
          margin:margin==null? addNewPageMargin:margin,
          decoration:selectWidgetBoxDecoration?? BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color:Color(0xFFCDCDCD)),
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Obx(
                    ()=>Expanded(
                      child: Text(selectedText.isEmpty? hinttext!: isToJson!?selectedText.join(','):selectedText.join(','),
                  style: TextStyle(color:selectedData.isEmpty? addNewTextFieldText.withOpacity(0.8):addNewTextFieldText,fontSize: 15,fontFamily: 'RR',overflow: TextOverflow.ellipsis),
                ),
                    ),
              ),
              Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.grey,),
              SizedBox(width: 15,)
            ],
          ),
        ),
        dialogWidget: Obx(
            ()=>Container(
              height: (dataNotifier.length*hei1)+150.0,
              width: width,
              margin:dialogMargin==null? EdgeInsets.only(left:SizeConfig.width100!,right:SizeConfig.width100!,top:5):dialogMargin,
              //padding: EdgeInsets.only(top: 10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: Offset(0,0)
                    )
                  ]
              ),
              constraints: BoxConstraints(
                  maxHeight: 400
              ),
              child: Column(
                children: [
                  !showSearch?Container():Container(
                    height: hei1,
                    width: width,
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      //    style: textFormTs1,
                      focusNode: f4,
                      decoration: InputDecoration(
                          hintText: "Search",
                          // hintStyle: textFormHintTs1,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15.0,)
                      ),
                      onEditingComplete: (){
                        f4.unfocus();
                      },
                      onChanged: (v){
                        dataNotifier.value=data!.where((element) => element.toString().toLowerCase().contains(v.toLowerCase())).toList();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     //SizedBox(width: 15,),
                      GestureDetector(
                        onTap: (){
                          clearValues();
                        },
                        child: Container(
                          height: 50,
                          //width: 100,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          alignment: Alignment.centerLeft,
                          child: Text("Clear All",style: TextStyle(fontSize: 15,fontFamily: 'RR'),),
                        ),
                      ),
                      //SizedBox(width: 15,),
                      GestureDetector(
                        onTap: (){
                          setValues(
                              data!.map((e) => e[propertyId]).toList().join(","),
                              data!.map((e) => e[propertyName]).toList().join(",")
                          );
                        },
                        child: Container(
                          height: 50,
                          //width: 100,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          alignment: Alignment.centerLeft,
                          child: Text("Select All",style: TextStyle(fontSize: 15,fontFamily: 'RR'),),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          doneCallback(getValue());
                        },
                        child: Container(
                          height: 50,
                          //width: 100,
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                          alignment: Alignment.centerLeft,
                          color: Colors.transparent,
                          child: Text("Done",style: TextStyle(fontSize: 15,fontFamily: 'RR'),),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Obx(
                            ()=>dataNotifier.isEmpty?Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text("No Data Found",style: AppTheme.textFormStyle,),
                        ):
                        ListView.builder(
                          itemCount: checked.value?dataNotifier.length:dataNotifier.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx,index){
                            return   InkWell(
                              onTap:(){
                                // Navigator.pop(ctx);
                                /* onitemTap(index);
                              selectedValueFunc(dataNotifier[index]);*/
                                checked.value=!checked.value;
                                if(selectedData.contains(dataNotifier[index][propertyId].toString())){
                                  dataNotifier[index]['checked']=false;
                                  selectedData.remove(dataNotifier[index][propertyId].toString());
                                  selectedText.remove(dataNotifier[index][propertyName]);
                                }
                                else{
                                  dataNotifier[index]['checked']=true;
                                  selectedData.add(dataNotifier[index][propertyId].toString());
                                  selectedText.add(dataNotifier[index][propertyName]);
                                }

                              },
                              child: Container(
                                height: 50,
                                width:width,
                                padding: EdgeInsets.only(left: 15,),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  //color:(isToJson?"${t[index][propertyName]}":"${t[index]}" )== (isToJson?selectedData[propertyName]:selectedData['value'])?AppTheme.restroTheme:Colors.white,
                                ),
                                child:  Row(
                                  children: [
                                    Obx(
                                          ()=>AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeIn,
                                              height:checked.value? 25:25,
                                              width: 25,
                                              margin: EdgeInsets.only(left: 0,right: 15),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color:dataNotifier[index]['checked']? AppTheme.restroTheme:Colors.white,
                                                  border: Border.all(color:dataNotifier[index]['checked']? Colors.transparent: Colors.grey,)
                                              ),
                                              child: Icon(Icons.done, color:dataNotifier[index]['checked']? Colors.white:Colors.grey, size: 15,),
                                      ),
                                    ),
                                    Text(isToJson!?"${dataNotifier[index][propertyName]}":"${dataNotifier[index]}",
                                      style: TextStyle(fontFamily: 'RR',fontSize: 15, color: Colors.grey,
                                        // color:(isToJson?"${t[index][propertyName]}":"${t[index]}" )== (isToJson?selectedData[propertyName]:selectedData['value'])?Colors.white: Colors.grey
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
        ),
        onChanged: (s){},
        clearButtonSplashRadius: 20,
        selectedItem:"",
        onBeforeChange: (a, b) {
          return Future.value(true);
        },
      ),
    );
  }
  getValue(){
    return selectedData.join(",");
  }
  setValues(String value, String nameList){
    selectedData.value=value.split(",");
    selectedText.value=nameList.split(",");
    data!.forEach((element) {if(selectedData.contains(element[propertyId].toString())){element['checked']=true;}});
    dataNotifier.forEach((element) {if(selectedData.contains(element[propertyId].toString())){element['checked']=true;}});
    checked.value=!checked.value;
  }
  setDataArray(List dataList){
    dataList.forEach((element) {element['checked']=false;});
    data=dataList;
    dataNotifier.value=dataList;
    checked.value=!checked.value;
  }
  clearValues(){
    selectedData.clear();
    selectedText.clear();
    data!.forEach((element) {element['checked']=false;});
    checked.value=!checked.value;
  }
  String getDataName(){
    return this.dataName;
  }
  getType(){
    return 'searchDrp';
  }
  validate(){

  }
}


checkNullEmpty(dynamic value){
  return value==null|| value=='';
}
EdgeInsets addNewPageMargin=EdgeInsets.only(left:20,right:20,top:20);