import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFunction {
  get context => null;

  Future logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.clear();

    return true;
  }

  Future getNik() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString('nik');
  }

  Future checkNik() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('nik')) {
      return true;
    } else
      return false;
  }

  void belumTersedia() {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return Container(
    //       height: 300,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(20),
    //           topRight: Radius.circular(20),
    //         ),
    //       ),
    //     );
    //   },
    // );
    BotToast.showText(text: "Layanan Belum Tersedia", contentColor: Colors.red);
  }
}
