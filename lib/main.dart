import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/introslider.dart';
import 'package:pelaport/my_function.dart';
import 'package:pelaport/views/home/home.dart';
import 'package:bot_toast/bot_toast.dart';

// bool _login = false;
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Segments SecurityPG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: secondarycolor,
        primarySwatch: primarySwatchColor,
      ),
      home: SplashScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // int _counter = 0;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2500)).then((value) {
      init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tinggilayar = MediaQuery.of(context).size.height;
    lebarlayar = MediaQuery.of(context).size.width;
    marginhorizontal = lebarlayar / 12;

    return Scaffold(
      backgroundColor: primarycolor,
      body: Container(
        height: tinggilayar,
        width: lebarlayar,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: Hero(
                  tag: "logo",
                  child: Image.asset('assets/logoputih.png', scale: 2.5)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: tinggilayar / 15),
                child: Image.asset('assets/pgputih.png', scale: 5.5),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future init() async {
    var value = await MyFunction().checkNik();

    if (value) {
      await ApiController().getUser().then((value) {
        if (mounted)
          setState(() {
            // print(value.status);
            if (value.status) {
              print("oke");

              dataUser = value.data;
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return MainScreen();
              }), (route) => false);

              BotToast.showText(
                  text: "Login Sukses",
                  crossPage: true,
                  textStyle: TextStyle(fontSize: 14, color: Colors.white),
                  contentColor: Colors.green);
            }
          });
      });
    } else {
      Navigator.push(context,
          CupertinoPageRoute(builder: (BuildContext builder) => IntroSlider()));
    }
  }
}
