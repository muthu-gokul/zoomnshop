import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../videoCall/common/util/app_color.dart';
import '../../videoCall/common/util/utility_function.dart';
import '../../videoCall/data_store/meeting_store.dart';
import '../../videoCall/enum/meeting_flow.dart';
import '../../videoCall/hls-streaming/hls_screen_controller.dart';
import '../../videoCall/hls-streaming/util/hls_title_text.dart';
import '../../videoCall/hms_app_settings.dart';
import '../../videoCall/hms_sdk_interactor.dart';
import '../../videoCall/logs/custom_singleton_logger.dart';
import '../../videoCall/preview/preview_details.dart';
import '../../videoCall/qr_code_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../videoCall/service/managementToken.dart';
import 'package:get/get.dart';

void showPreview(bool res,name,url) async {

  Utilities.setRTMPUrl(url);
  MeetingFlow flow = Utilities.deriveFlow(url);
    Utilities.saveStringData(key: "name", value: name);
    res = await Utilities.getPermissions();
    if (res) {
      /*if (!skipPreview) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => ListenableProvider.value(
                    value: PreviewStore(),
                    child: PreviewPage(
                        meetingFlow: widget.meetingFlow,
                        name: nameController.text,
                        meetingLink: widget.meetingLink),
                  )));
        } else {*/
      bool showStats =false;
      bool mirrorCamera = await Utilities.getBoolData(key: 'mirror-camera') ?? false;
      HMSSDKInteractor _hmsSDKInteractor = HMSSDKInteractor();

      Navigator.push(Get.context!, MaterialPageRoute(
          builder: (_) => ListenableProvider.value(
            value: MeetingStore(hmsSDKInteractor: _hmsSDKInteractor),
            child: HLSScreenController(
              isRoomMute: false,
              isStreamingLink: flow == MeetingFlow.meeting
                  ? false
                  : true,
              isAudioOn: true,
              meetingLink: url,
              localPeerNetworkQuality: -1,
              user: name,
              mirrorCamera: mirrorCamera,
              showStats: showStats,
            ),
          )));
    }

}


class HomePageVideoCall extends StatefulWidget {
  final String? deepLinkURL;

  const HomePageVideoCall({Key? key, this.deepLinkURL}) : super(key: key);
  @override
  State<HomePageVideoCall> createState() => _HomePageVideoCallState();
// static _HomePageVideoCallState of(BuildContext context) =>
//     context.findAncestorStateOfType<_HomePageVideoCallState>()!;
}
class _HomePageVideoCallState extends State<HomePageVideoCall> {
  TextEditingController meetingLinkController = TextEditingController(text: 'https://isha.app.100ms.live/meeting/acc-ywo-tjh');
  //TextEditingController meetingLinkController = TextEditingController(text: 'https://zoomnshop.app.100ms.live/meeting/Classroom');
  CustomLogger logger = CustomLogger();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    logger.getCustomLogger();

    generateManagementToken().then((value){
      print("generateManagementToken $value");
    });
    // _initPackageInfo();
    // getData();
  }

  void getData() async {
    String savedMeetingUrl = await Utilities.getStringData(key: 'meetingLink');
    if (widget.deepLinkURL == null && savedMeetingUrl.isNotEmpty) {
      meetingLinkController.text = savedMeetingUrl;
    } else {
      meetingLinkController.text = widget.deepLinkURL ?? "";
    }
  }

  Future<bool> _closeApp() {
    CustomLogger.file?.delete();
    return Future.value(true);
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void didUpdateWidget(covariant HomePageVideoCall oldWidget) {
    if (widget.deepLinkURL != null) {
      meetingLinkController.text = widget.deepLinkURL!;
    }
    super.didUpdateWidget(oldWidget);
  }

  void joinMeeting() {
    if (meetingLinkController.text.isEmpty) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Utilities.setRTMPUrl(meetingLinkController.text);
    MeetingFlow flow = Utilities.deriveFlow(meetingLinkController.text.trim());
    if (flow == MeetingFlow.meeting || flow == MeetingFlow.hlsStreaming) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PreviewDetails(
                autofocusField: true,
                meetingLink: meetingLinkController.text.trim(),
                meetingFlow: flow,
              )));
    } else {
      Utilities.showToast("Please enter valid url");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _closeApp,
      child: SafeArea(
        child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/welcome.svg',
                      width: width * 0.95,
                    ),

                    TextButton(onPressed: () async {
                      createRoomFromApi("Classroom");
/*List<String?>? a=await RoomService().getToken(user: "Muhtu", room:'https://zoomnshop.app.100ms.live/meeting/gjo-arr-qfj');
                  print(a);*/

                    }, child: Text("Create Room")),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text('Experience the power of 100ms',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              letterSpacing: 0.25,
                              color: themeDefaultColor,
                              height: 1.17,
                              fontSize: 34,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27),
                      child: Text(
                          'Jump right in by pasting a room link or scanning a QR code',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              letterSpacing: 0.5,
                              color: themeSubHeadingColor,
                              height: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Joining Link",
                              key: Key('joining_link_text'),
                              style: GoogleFonts.inter(
                                  color: themeDefaultColor,
                                  height: 1.5,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        key: Key('meeting_link_field'),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          joinMeeting();
                        },
                        style: GoogleFonts.inter(),
                        controller: meetingLinkController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            focusColor: hmsdefaultColor,
                            contentPadding: EdgeInsets.only(left: 16),
                            fillColor: themeSurfaceColor,
                            filled: true,
                            hintText: 'Paste the link here',
                            hintStyle: GoogleFonts.inter(
                                color: hmsHintColor,
                                height: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            suffixIcon: meetingLinkController.text.isEmpty
                                ? null
                                : IconButton(
                              onPressed: () {
                                meetingLinkController.text = "";
                                setState(() {});
                              },
                              icon: Icon(Icons.clear),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: borderColor, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: width * 0.95,
                      child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: meetingLinkController,
                          builder: (context, value, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: meetingLinkController.text.isEmpty
                                    ? themeSurfaceColor
                                    : hmsdefaultColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shadowColor: MaterialStateProperty.all(
                                                themeSurfaceColor),
                                            backgroundColor:
                                            meetingLinkController.text.isEmpty
                                                ? MaterialStateProperty.all(
                                                themeSurfaceColor)
                                                : MaterialStateProperty.all(
                                                hmsdefaultColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ))),
                                        onPressed: () async {
                                          joinMeeting();
                                        },
                                        child: Container(
                                          padding:
                                          const EdgeInsets.fromLTRB(60, 12, 8, 12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(8))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              HLSTitleText(
                                                key: Key('join_now'),
                                                text: 'Join Now',
                                                textColor:
                                                meetingLinkController.text.isEmpty
                                                    ? themeDisabledTextColor
                                                    : enabledTextColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: (() => showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        context: context,
                                        builder: (ctx) => HMSAppSettings())),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child:Text("More "),
                                      /*child: SvgPicture.asset(
                                    "assets/icons/more.svg",
                                    color: meetingLinkController.text.isEmpty
                                        ? themeDisabledTextColor
                                        : hmsWhiteColor,
                                    fit: BoxFit.scaleDown,
                                  ),*/

                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: width * 0.95,
                        child: Divider(
                          height: 5,
                          color: dividerColor,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: width * 0.95,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(hmsdefaultColor),
                            backgroundColor:
                            MaterialStateProperty.all(hmsdefaultColor),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                        onPressed: () async {
                          bool res = await Utilities.getCameraPermissions();
                          if (res) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => QRCodeScreen()));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 18,
                                color: enabledTextColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              HLSTitleText(
                                  key: Key("scan_qr_code"),
                                  text: 'Scan QR Code',
                                  textColor: enabledTextColor)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}


/*
class TW extends StatefulWidget {
  const TW({Key? key}) : super(key: key);

  @override
  State<TW> createState() => _TWState();
}

class _TWState extends State<TW> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(

      ),
    );
  }
}*/

