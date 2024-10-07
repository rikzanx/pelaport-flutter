import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/views/home/home.dart';
import 'package:pelaport/views/schedule/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../apicontroller.dart';

class LoginNew extends StatefulWidget {
  const LoginNew({Key? key}) : super(key: key);

  @override
  LoginNewState createState() => LoginNewState();
}

class LoginNewState extends State<LoginNew> {
  TextEditingController _passwordcontroller = new TextEditingController();
  TextEditingController _nikcontroller = new TextEditingController();
  final _formkey = new GlobalKey<FormFieldState>();
  bool _showpassword = false;
  bool isPasswordVisible = false;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers
    _nikcontroller.addListener(_validateEmail);
    _passwordcontroller.addListener(_validatePassword);
    getDataBerita();
    _showpassword = false;
  }

  @override
  void dispose() {
    // Remove listeners when the widget is disposed
    _nikcontroller.removeListener(_validateEmail);
    _passwordcontroller.removeListener(_validatePassword);
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      isEmailValid = _nikcontroller.text.isNotEmpty;
    });
  }

  void _validatePassword() {
    setState(() {
      isPasswordValid = _passwordcontroller.text.isNotEmpty;
    });
  }

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
            saveId(value['id_regu'].toString(), value['id_karyawan'].toString(),
                    value['nik'].toString(), _passwordcontroller.text)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
      body: Stack(
        children: [
          buildLoginBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildAppLogo(),
                // buildAppTitle(),
                buildLoginForm(),
                buildLoginButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/login_background.png',
        fit: BoxFit.cover,
      ),
    );
  }

  // Widget buildCompanyImages() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         buildImageAsset(LoginAssets.bumnLogo),
  //         buildImageAsset(LoginAssets.pupukIndonesiaLogo),
  //         buildImageAsset(LoginAssets.petrokimiaGresikLogo),
  //       ],
  //     ),
  //   );
  // }

  Widget buildAppLogo() {
    return Image.asset(
      'assets/logowarna.png',
      width: 170.0,
      height: 80.0,
    );
  }

  // Widget buildAppTitle() {
  //   return Text(
  //     "Silahkan login terlebih dahulu.",
  //     style: TextStyle(
  //         fontWeight: FontWeight.bold, fontSize: tinggilayar / lebarlayar * 8),
  //   );
  // }

  Widget buildImageAsset(String assetPath) {
    return Image.asset(
      assetPath,
      width: 40.0,
      height: 40.0,
    );
  }

  Widget buildWelcomeText() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        'LoginAssets.sacText',
        style: TextStyle(
          color: Color.fromRGBO(0, 1, 49, 63),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildTextField(_nikcontroller, 'NIK', Icons.account_circle),
          buildPasswordField(_passwordcontroller, 'Password', Icons.lock),
        ],
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String labelText,
    IconData prefixIcon,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
      child: Material(
        elevation: 4, // Set elevation to add shadow
        borderRadius: BorderRadius.circular(4), // Adjust as needed
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(prefixIcon),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isEmailValid ? Colors.white : Colors.red,
              ),
              borderRadius: BorderRadius.circular(8), // Adjust as needed
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(1, 49, 63, 91),
              ),
              borderRadius: BorderRadius.circular(8), // Adjust as needed
            ),
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              // Add any additional text style properties if needed
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(
    TextEditingController controller,
    String labelText,
    IconData prefixIcon,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Material(
        elevation: 4, // Set elevation to add shadow
        borderRadius: BorderRadius.circular(4), // Adjust as needed
        child: TextField(
          obscureText: !isPasswordVisible,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isPasswordValid ? Colors.white : Colors.red,
              ),
              borderRadius: BorderRadius.circular(8), // Adjust as needed
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(1, 49, 63, 100),
              ),
              borderRadius: BorderRadius.circular(8), // Adjust as needed
            ),
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              // Add any additional text style properties if needed
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0), // Add space on top
      height: 55,
      width: 1920,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Material(
        elevation: 4, // Set elevation to add shadow
        borderRadius: BorderRadius.circular(8), // Adjust as needed
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(239, 45, 155, 47),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // Adjust as needed
            ),
          ),
          onPressed: _save,
          child: Text(
            'M A S U K',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold, // Add this line for bold text
            ),
          ),
        ),
      ),
    );
  }
}
