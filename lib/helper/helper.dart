import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zoomnshop/api/apiUtils.dart';
import '../api/ApiManager.dart';
import '../widgets/alertDialog.dart';

class MyHelper{
  static Future<String> uploadFile(String folderName, File file) async{
    showLoader.value=true;
    try{
      final postUri = Uri.parse("${GetBaseUrl()}/api/Common/Upload?BaseFolder="+folderName);
      http.MultipartRequest request = http.MultipartRequest('POST', postUri);
      List files=[file];
      for(int i=0;i<1;i++){
        File imageFile = files[i];
        var stream = new http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = new http.MultipartFile("file", stream, length,
            filename: imageFile.path.split('/').last);
        request.files.add(multipartFile);
      }
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      showLoader.value=false;
      return res.body.replaceAll('"', '');
    }catch(e,t){
      showLoader.value=false;
      CustomAlert().commonErrorAlert("Upload", "$e _ $t");
      return "";
    }
  }
}