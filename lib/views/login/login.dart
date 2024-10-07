import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/views/home/home.dart';
import 'package:pelaport/views/schedule/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../apicontroller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _passwordcontroller = new TextEditingController();
  TextEditingController _nikcontroller = new TextEditingController();
  final _formkey = new GlobalKey<FormFieldState>();
  bool _showpassword = false;

  void initState() {
    super.initState();
    getDataBerita();
    _showpassword = false;
  }

  @override
  Widget build(BuildContext context) {
    saveToken(token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    saveId(idRegu, idKaryawan, nik, password) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('id_regu', idRegu);
      await prefs.setString('id_karyawan', idKaryawan);
      await prefs.setString('nik', nik);
      await prefs.setString('password', password);
    }

    Future _initUser() async {
      await ApiController().getUser().then((value) {
        if (mounted)
          setState(() {
            dataUser = value.data;
            print("ok");
            print(dataUser);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return MainScreen();
            }), (route) => false);

            BotToast.showText(
                text: "Login Sukses",
                crossPage: true,
                textStyle: TextStyle(fontSize: 14, color: Colors.white),
                contentColor: Colors.green);
          });
      });
    }

    // print(body);\
    Future<String?> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.androidId; // unique ID on Android
      }
    }

    Future _save() async {
      String? idDevice = "unknown";

      idDevice = await _getId();
      print(idDevice);

      if (idDevice != "unknown") {
        BotToast.showLoading();
        Map<String, String> body = {
          'nik': _nikcontroller.text,
          'password': _passwordcontroller.text,
        };
        await ApiController().login(body).then(
          (response) {
            var value = response.data;
            print(response.status);
            print(response.data);
            print(value);
            if (response.status == false) {
              BotToast.closeAllLoading();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(value['message']),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else if (response.status == true) {
              BotToast.closeAllLoading();
              saveToken(value['token']);
              saveId(
                      value['id_regu'].toString(),
                      value['id_karyawan'].toString(),
                      value['nik'].toString(),
                      _passwordcontroller.text)
                  .then((value) {
                _initUser();
              });
            } else {
              BotToast.closeAllLoading();
              showDialog(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text('Pastikan mengisi dengan benar'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Device tidak diketahui'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: secondarycolor,
      body: SingleChildScrollView(
        child: Container(
          height: tinggilayar,
          width: lebarlayar,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: tinggilayar / 40,
                  child: Container(
                    child: Image.asset('assets/logowarna.png', scale: 2.5),
                  ),
                ),
                Positioned(
                  top: tinggilayar / 6,
                  child: Container(
                    padding: EdgeInsets.only(bottom: tinggilayar / 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28)),
                        color: primarycolor),
                    width: lebarlayar,
                    height: tinggilayar / 8,
                    child: Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: tinggilayar / lebarlayar * 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: tinggilayar / 4,
                  child: Form(
                    key: _formkey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: marginhorizontal,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: Text(
                              'Selamat Datang',
                              style: TextStyle(
                                fontSize: tinggilayar / lebarlayar * 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 50,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: Text(
                              'Masuk dengan menggunakan akunmu',
                              style: TextStyle(
                                  fontSize: tinggilayar / lebarlayar * 7),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 40,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: TextFormField(
                              controller: _nikcontroller,
                              decoration: InputDecoration(labelText: 'NIK'),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 40,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: marginhorizontal),
                            child: TextFormField(
                              controller: _passwordcontroller,
                              obscureText: !_showpassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showpassword = !_showpassword;
                                      });
                                    },
                                    child: Icon(_showpassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: tinggilayar / 15,
                          ),
                          PrimaryButton(
                            warna: Colors.white,
                            onClick: () {
                              _save();
                            },
                            teksnya: 'M A S U K',
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)),
                          color: Colors.white),
                      height: tinggilayar / 1.48,
                      width: lebarlayar,
                    ),
                  ),
                ),
              ],
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
