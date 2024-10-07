
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/constant.dart';
// import 'package:safe_device/safe_device.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:trust_location/trust_location.dart';

class PresensiMasuk extends StatefulWidget {
  const PresensiMasuk({Key? key}) : super(key: key);

  @override
  _PresensiMasukState createState() => _PresensiMasukState();
}

var data;

class _PresensiMasukState extends State<PresensiMasuk> {
  final lokasiController = TextEditingController();
  double lat = 0.0, lng = 0.0;

  String action = "";
  bool canMockLocation = true;
  bool isMockLocation = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  cek() async {
  }

  @override
  Widget build(BuildContext context) {

    Future _save() async {
      // TrustLocation.start(5);
      // getLocation();
      
      print(isMockLocation);
      print("SAFE DEVICE : $canMockLocation");
      if (isMockLocation)
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Gagal Absen'),
              content: Text(
                  "HP anda terdeteksi mengaktifkan mock gps (fake gps) mohon untuk mematikan perijinan dan tidak memakai aplikasi fake gps"),
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
      else {
        BotToast.showLoading();
        print(data);
        var body = {
          'nama_lengkap': data['karyawan']['nama_lengkap'].toString(),
          'user_id_penerima': data['karyawan']['jabatan']['atasan_1']['user']
                  ['id_user']
              .toString(),
          'niknik': data['karyawan']['user']['nik'].toString(),
          'lat': lat.toString(),
          'lng': lng.toString(),
          'id_zona': data['karyawan']['zona']['id_zona'].toString(),
          'id_regu': data['karyawan']['regu']['id_regu'].toString(),
          'id_jabatan': data['karyawan']['jabatan']['id_jabatan'].toString()
        };
        // print(action);
        if (action == "OFF") {
          body['jadwal_kerja'] = "OFF";
        } else {
          body['jadwal_kerja'] = "|" +
              data['jadwal']['action'].toString() +
              "|" +
              "  " +
              data['jadwal']['jam_masuk'].toString() +
              " - " +
              data['jadwal']['jam_keluar'].toString();
        }
        print("ini bisa");
        await ApiController().checkin(body).then((response) {
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
                  content: Text('Gagal checkin'),
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
    }

    

    return Scaffold(
      bottomSheet: PrimaryButton(
        warna: secondarycolor,
        onClick: () {
          _save();
        },
        teksnya: "Kirim",
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
          "Presensi Masuk",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: tinggilayar * 1.1,
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
                    horizontal: marginhorizontal, vertical: tinggilayar / 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jadwal Masuk",
                      style: TextStyle(fontSize: tinggilayar / lebarlayar * 7),
                    ),
                    SizedBox(
                      height: tinggilayar / 100,
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        suffixIcon: Icon(Icons.calendar_today),
                        hintText: data == null
                            ? ""
                            : "|" +
                                data['jadwal']['action'].toString() +
                                "|" +
                                "  " +
                                data['jadwal']['jam_masuk'].toString() +
                                " - " +
                                data['jadwal']['jam_keluar'].toString(),
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
                height: 210,
                child: lat == 0.0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : WebView(
                        initialUrl:
                            '$protokol$baseUrl/maps/android?lat=$lat&lng=$lng',
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
      ),
    );
  }

  Future init() async {
    await ApiController().getUser().then((value) {
      if (mounted)
        setState(() {
          data = value.data;
          action = value.data["jadwal"]["action"];
          print("data=$action");
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
    bool hasil = await TrustLocation.isMockLocation;
    setState(() {
      isMockLocation = hasil;
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

class InfoUser extends StatelessWidget {
  const InfoUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
            width: lebarlayar,
            height: tinggilayar / 2.5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                    blurRadius: 5,
                    color: Colors.grey.shade400)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: lebarlayar / 3,
                    height: tinggilayar / 4,
                    child: Image.network(
                      protokol +
                          baseUrl +
                          "/assets/foto_profil/" +
                          data['karyawan']['user']['foto'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: marginhorizontal,
                        vertical: tinggilayar / 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "NIK : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    data['karyawan']['user']['nik'].toString(),
                              )
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 7),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Nama : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: data['karyawan']['nama_lengkap']
                                      .toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 7),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Zona : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: data['karyawan']['zona']['nama_zona']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 7),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Regu : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: data['karyawan']['regu']['nama_regu']
                                      .toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 7),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Jabatan : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: data['karyawan']['jabatan']
                                          ['nama_jabatan']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 7),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
