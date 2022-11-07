import 'package:flutter/material.dart';

import '../styles/style.dart';


class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
           // child: Image.asset("assets/errors/no-search-items.png"),
          ),
         // SizedBox(height: 10,),
          Text("No data found",style: ts18(Color(0xff787878)),)
        ],
      ),
    );
  }
}
