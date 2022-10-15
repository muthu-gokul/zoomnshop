import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../pages/loginpage/login.dart';
import 'package:wakelock/wakelock.dart';
import 'notifier/themeNotifier.dart';

/*void main() {
  runApp(const MyApp());
}*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  Wakelock.enable();
//  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ThemeNotifier()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZoomNShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:CarouselDemo(),
        home: loginPage(),
        //  home: ViewProductDetails(),
      ),
    );

  }
}