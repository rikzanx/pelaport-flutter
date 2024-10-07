import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/models/laporan.dart';
import 'package:pelaport/my_function.dart';
import 'package:pelaport/views/home/detail_laporan/detail_laporan.dart';
import 'package:pelaport/views/login/login.dart';
import 'package:pelaport/views/login/login_new.dart';
// import 'package:pelaport/views/notifikasi/notifikasi.dart';
import 'package:pelaport/views/profile/edit.dart';

import '../../home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool buttongridclicked = false;
  bool buttonlistclicked = true;
  var data;

  List<Laporan> myLaporan = [];
  int menunggu = 0;
  int proses = 0;
  int selesai = 0;

  @override
  void initState() {
    getDataMyLaporan(dataUser['karyawan']['nik']);
    getStatusLaporan(dataUser['karyawan']['nik']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: tinggilayar / 50),
            height: tinggilayar / 1.1,
            width: lebarlayar,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: Text(
                    "Profil",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: tinggilayar / lebarlayar * 12),
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(marginhorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              foregroundImage: NetworkImage(
                                protokol +
                                    baseUrl +
                                    "/assets/foto_profil/" +
                                    dataUser['karyawan']['user']['foto'],
                              ),
                            ),
                            SizedBox(
                              width: lebarlayar / 20,
                            ),
                            Container(
                              width: lebarlayar / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataUser['karyawan']['pt'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: tinggilayar / lebarlayar * 6),
                                  ),
                                  Text(
                                    dataUser['karyawan']['nama_lengkap'],
                                    style: TextStyle(
                                        fontSize: tinggilayar / lebarlayar * 6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataUser['karyawan']['zona']['nama_zona'],
                                    style: TextStyle(
                                        color: primarycolor,
                                        fontSize: tinggilayar / lebarlayar * 5),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: tinggilayar / 60,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "NIK : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: dataUser['karyawan']['nik'].toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
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
                                  text: dataUser['karyawan']['zona']
                                          ['nama_zona']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
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
                                  text: dataUser['karyawan']['regu']
                                          ['nama_regu']
                                      .toString())
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
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
                                  text: dataUser['karyawan']['jabatan']
                                          ['nama_jabatan']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                            ],
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: tinggilayar / lebarlayar * 6),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Colors.grey.shade400),
                        ]),
                    height: tinggilayar / 3.4,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        vertical: tinggilayar / 15,
                        horizontal: marginhorizontal),
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  menunggu.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 7),
                                ),
                                Text(
                                  "Menunggu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 5),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  proses.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 7),
                                ),
                                Text(
                                  "Proses",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 5),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selesai.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 7),
                                ),
                                Text(
                                  "Selesai",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tinggilayar / lebarlayar * 5),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    height: tinggilayar / 12,
                    width: lebarlayar / 1.7,
                    margin: EdgeInsets.symmetric(vertical: tinggilayar / 3.1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primarycolor),
                  ),
                ),
                //LOGOUT
                Positioned(
                  right: 32,
                  child: ElevatedButton(
                      onPressed: () async {
                        await MyFunction().logout();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginNew();
                        }), (route) => false);
                      },
                      child: Icon(Icons.logout)),
                ),
                //EDIT
                Positioned(
                    left: 32,
                    child: IconButton(
                      onPressed: () {
                        //action coe when button is pressed
                        pindahPageCupertino(context, Edit());
                      },
                      icon: Icon(
                        Icons.edit,
                        color: primarycolor,
                      ),
                    )),
                SizedBox.expand(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    minChildSize: 0.5,
                    maxChildSize: 1,
                    builder: (BuildContext context, listController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListView(
                          padding: EdgeInsets.only(bottom: tinggilayar / 15),
                          controller: listController,
                          children: [
                            SizedBox(
                              height: tinggilayar / 80,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: lebarlayar / 3),
                              color: Colors.grey,
                              height: 5,
                            ),
                            SizedBox(
                              height: tinggilayar / 30,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: lebarlayar / 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: lebarlayar / 3,
                                    child: Text(
                                      "Laporan Saya",
                                      style: TextStyle(
                                          fontSize:
                                              tinggilayar / lebarlayar * 6),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              buttongridclicked = true;
                                              buttonlistclicked = false;
                                            });
                                          },
                                          child: Icon(Icons.grid_view)),
                                      SizedBox(
                                        width: lebarlayar / 50,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                buttongridclicked = false;
                                                buttonlistclicked = true;
                                              },
                                            );
                                          },
                                          child: Icon(Icons.list_rounded)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: tinggilayar / 40,
                            ),
                            // ... rest of your code
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getDataMyLaporan(String nik) async {
    Map<String, String> body = {'nik': nik};
    var response = await ApiController().getDataMyLaporan(body);
    List<Laporan> laporanList = new List.empty(growable: true);
    var jsonlist = response.data as List;
    print(jsonlist);
    jsonlist.forEach((element) {
      laporanList.add(Laporan.fromJson(element));
    });
    print(laporanList);
    setState(() {
      myLaporan = laporanList;
    });
  }

  Future getStatusLaporan(String nik) async {
    Map<String, String> body = {'nik': nik};
    var response = await ApiController().getStatusLaporan(body);
    if (response.status) {
      setState(() {
        menunggu = response.data['menunggu'];
        proses = response.data['proses'];
        selesai = response.data['selesai'];
      });
    }
  }
}
