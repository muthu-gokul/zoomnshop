//dart imports
import 'dart:convert';

//Package imports
import '../common/constant.dart';
import 'package:http/http.dart' as http;

class RoomService {
  Future<List<String?>?> getToken(
      {required String user, required String room}) async {
    Constant.meetingUrl = room;
    List<String?> codeAndDomain = getCode(room) ?? [];
//zoomnshop.app.100ms.live
    /*try{
      http.Response response1 = await http.post(Uri.parse("https://prod-in.100ms.live/hmsapi/get-token"),
          body: {'user_id': user, 'role': Constant.defaultRole,'code': "ugf-phm-jxo"
          },
          headers: {
            'subdomain': "zoomnshop.app.100ms.live"
          }
      );
      var body1 = json.decode(response1.body);
      print("respomse1 $body1");
    }catch(e){
      print("respomse1 catvch $e");
    }*/

    if (codeAndDomain.length == 0) {
      return null;
    }
    Constant.meetingCode = codeAndDomain[1] ?? '';
    Uri endPoint = codeAndDomain[2] == "true"
        ? Uri.parse(Constant.prodTokenEndpoint)
        : Uri.parse(Constant.qaTokenEndPoint);
    try {

     // var tempBody={'code': codeAndDomain[1], 'user_id': user};
      var tempBody={'user_id': '634400644208780bf665757a', 'role': Constant.defaultRole,'room_id':'63454ef79faa9c00f965a90e',};
      //var tempBody={'user_id': '634400644208780bf665757a', 'role': Constant.defaultRole,'room_id':'63454ef79faa9c00f965a90e',};
      //https://prod-in2.100ms.live/hmsapi/get-token

     // http.Response response = await http.post(Uri.parse("https://prod-in2.100ms.live/hmsapi/zoomnshop.app.100ms.live/api/token"), body: {
      //'user_id': '634400644208780bf665757a', 'role': Constant.defaultRole,'room_id':'63454ef79faa9c00f965a90e'
      http.Response response = await http.post(Uri.parse("https://prod-in2.100ms.live/hmsapi/zoomnshop.app.100ms.live/api/token"), body: tempBody,
          headers: {
        'subdomain': (codeAndDomain[0] ?? "").trim(),
        //'Content-Type': 'application/json'
      });
      print("codeAndDomain[1] ${codeAndDomain[1]}");
      print("codeAndDomain[0] ${codeAndDomain[0]}");
      print("res ${response.body}");
      var body = json.decode(response.body);

      return [body['token'], codeAndDomain[2]!.trim()];
    }
    catch (e) {
      return null;
    }
  }

  List<String?>? getCode(String roomUrl) {
    String url = roomUrl;
    if (url == "") return [];
    url = url.trim();
    bool isQa = url.contains("qa-app");
    bool isProd = url.contains(".app");

    if (!isProd && !isQa) return [];

    List<String> codeAndDomain = [];
    String code = "";
    String subDomain = "";
    codeAndDomain =
        isProd ? url.split(".app.100ms.live") : url.split(".qa-app.100ms.live");
    code = codeAndDomain[1];
    subDomain = codeAndDomain[0].split("https://")[1] +
        (isProd ? ".app.100ms.live" : ".qa-app.100ms.live");
    if (code.contains("meeting"))
      code = code.split("/meeting/")[1];
    else
      code = code.split("/preview/")[1];
    return [subDomain, code, isProd ? "true" : "false"];
  }
}
