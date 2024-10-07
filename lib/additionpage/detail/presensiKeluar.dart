import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/presensi.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PresensiKeluar extends StatefulWidget {
  const PresensiKeluar({Key? key}) : super(key: key);

  @override
  _PresensiKeluarState createState() => _PresensiKeluarState();
}

class _PresensiKeluarState extends State<PresensiKeluar> {
  final lokasiController = TextEditingController();
  double lat = 0.0, lng = 0.0;

  String jammasuk = "";

  // ignore: non_constant_identifier_names
  String id_presensi = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    Future _save() async {
      BotToast.showLoading();

      await ApiController().checkout(id_presensi: id_presensi).then((response) {
        var value = response.data;
        if (value['success'] == true) {
          BotToast.closeAllLoading();
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Succes'),
                content: Text(value['message']),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        } else {
          BotToast.closeAllLoading();
          showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
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
        }
      });
    }

    return Scaffold(
      bottomSheet: PrimaryButton(
        warna: secondarycolor,
        onClick: () {
          _save();
        },
        teksnya: "Check Out",
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: primarycolor,
            ),
          ),
        ),
        title: Text(
          "Presensi Keluar",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: tinggilayar,
        width: lebarlayar,
        child: Column(
          children: [
            InfoUser(),
            SizedBox(
              height: tinggilayar / 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      color: Colors.grey.shade400)
                ],
              ),
              width: lebarlayar,
              padding: EdgeInsets.symmetric(
                  horizontal: marginhorizontal, vertical: tinggilayar / 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jam Check In"),
                  SizedBox(
                    height: tinggilayar / 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      suffixIcon: Icon(Icons.calendar_today),
                      hintText: jammasuk,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: tinggilayar / 40,
            ),
            SizedBox(
              height: 200,
              child: lat == 0.0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : WebView(
                      initialUrl:
                          'http://$baseUrl/maps/android?lat=$lat&lng=$lng',
                      javascriptMode: JavascriptMode.unrestricted,
                      onProgress: (int progress) {
                        print(
                            "MyLog WebView is loading (progress : $progress%)");
                      },
                      onPageStarted: (String url) {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                        print('Page started loading: $url');
                      },
                      onPageFinished: (String url) {
                        // setState(() {
                        //   mapLoading = false;
                        // });
                        print('MyLog age finished loading: $url');
                      },
                      gestureNavigationEnabled: true,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future init() async {
    await ApiController().getUser().then((response) {
      var value = response.data;
      if (mounted)
        setState(() {
          data = value;
          print("data=$data");
        });
    });
    await ApiController().getJamMasuk().then((response) {
      var value = response.data; 
      if (mounted)
        setState(() {
          jammasuk = value["check_in"];
          id_presensi = value["id_presensi"].toString();
        });
    });
    await ApiController().getCurrentLocation().then((value) {
      if (mounted)
        setState(() {
          lat = value.latitude;
          lng = value.longitude;
          lokasiController.text = lat.toString() + ", " + lng.toString();
        });
    });
  }
}

class BoxDeskripsi extends StatelessWidget {
  const BoxDeskripsi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 5,
              color: Colors.grey.shade400)
        ],
      ),
      width: lebarlayar,
      padding: EdgeInsets.symmetric(
          horizontal: marginhorizontal, vertical: tinggilayar / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deskripsi"),
          SizedBox(
            height: tinggilayar / 50,
          ),
          TextFormField(
            maxLines: 6,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              hintText: "Deskripsi Disini...",
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
