import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pelaport/additionpage/absen.dart';
import 'package:pelaport/additionpage/pengajuan.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/views/homes/homekah.dart';
import 'package:pelaport/views/homes/homes.dart';
import 'package:pelaport/additionpage/kehadiran.dart';
import 'package:pelaport/views/home/widget/tab.dart';
import 'package:pelaport/views/laporan/tambah.dart';
import 'package:pelaport/views/list_data/list_data.dart';
import 'package:pelaport/views/profile/profile.dart';
import 'package:pelaport/views/schedule/schedule.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:pelaport/views/schedule/utils.dart';

// import '../../my_function.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

final tabs = ['Home', 'Jadwal', 'Data', 'Profile'];

class _MainScreenState extends State<MainScreen> {
  bool exit2 = false;
  int selectedPosition = 0;
  List<Widget> listWidget = [
    Homekah(),
    Schedule(
      title: 'Jadwal Kerja',
    ),
    // Cari(),
    ListData(),
    Profile(),
  ];
  late BuildContext context;
  bool opened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          if (exit2 == false) {
            setState(() {
              exit2 = true;
              Future.delayed(Duration(seconds: 2))
                  .then((value) => exit2 = false);
            });
            Fluttertoast.showToast(msg: "Ketuk 2 kali untuk keluar");
            return Future.value(false);
          } else {
            Fluttertoast.showToast(msg: "Keluar");
            return Future.value(true);
          }
        },
        child: Builder(
          builder: (BuildContext context) {
            this.context = context;
            return listWidget[selectedPosition];
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: primarycolor,
      //   onPressed: _showBottomSheet,
      //   child: Icon(opened == false ? Icons.add : Icons.close),
      //   elevation: 0,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomTab(),
    );
  }

  _showBottomSheet() {
    setState(
      () {
        if (opened == false) {
          opened = true;
          Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
            return GestureDetector(
              onHorizontalDragStart: (_) {},
              onVerticalDragUpdate: (_) {},
              onVerticalDragStart: (_) {},
              onHorizontalDragCancel: () {},
              onVerticalDragCancel: () {},
              onVerticalDragEnd: (_) {},
              onVerticalDragDown: (_) {},
              behavior: HitTestBehavior.opaque,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: lebarlayar / 7, vertical: tinggilayar / 20),
                  height: tinggilayar / 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color(0xFFEFEFEF),
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet();
                              pindahPageCupertino(context, Kehadiran());
                            },
                            child: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: tinggilayar / 20,
                                        width: lebarlayar / 5,
                                        child: Image.asset("assets/hadir.png")),
                                    Text(
                                      "Kehadiran",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              tinggilayar / lebarlayar * 5),
                                    ),
                                  ],
                                ),
                              ),
                              height: tinggilayar / 9,
                              width: lebarlayar / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet();
                              pindahPageCupertino(context, Absen());
                            },
                            child: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: tinggilayar / 20,
                                        width: lebarlayar / 5,
                                        child: Image.asset("assets/absen.png")),
                                    Text(
                                      "Absen",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              tinggilayar / lebarlayar * 5),
                                    ),
                                  ],
                                ),
                              ),
                              height: tinggilayar / 9,
                              width: lebarlayar / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet();
                              pindahPageCupertino(context, Pengajuan());
                            },
                            child: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: tinggilayar / 20,
                                      width: lebarlayar / 5,
                                      child: Image.asset(
                                        "assets/pengajuan.png",
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    Text(
                                      "Pengajuan",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              tinggilayar / lebarlayar * 5),
                                    ),
                                  ],
                                ),
                              ),
                              height: tinggilayar / 9,
                              width: lebarlayar / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet();
                              pindahPageCupertino(context, TambahLaporan());
                              // MyFunction().belumTersedia();
                            },
                            child: Container(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: tinggilayar / 20,
                                      width: lebarlayar / 5,
                                      child: Image.asset(
                                        "assets/laporan.png",
                                      ),
                                    ),
                                    Text(
                                      "Pelaporan",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              tinggilayar / lebarlayar * 5),
                                    ),
                                  ],
                                ),
                              ),
                              height: tinggilayar / 9,
                              width: lebarlayar / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )),
                ),
              ),
            );
          }, backgroundColor: Colors.black.withOpacity(0.2));
        } else {
          opened = false;
          Navigator.pop(context);
        }
      },
    );
  }

  _buildBottomTab() {
    return Container(
      width: lebarlayar,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurRadius: 1,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: GNav(
          rippleColor: Color.fromARGB(255, 255, 255, 255),
          hoverColor: const Color.fromARGB(255, 238, 236, 236),
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: primarycolor, width: 1),
          tabBorder: Border.all(color: Colors.grey, width: 1),
          tabShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 255, 255, 255), blurRadius: 4)
          ],
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 200),
          gap: 4,
          color: Color.fromARGB(255, 160, 160, 160),
          activeColor: primarycolor,
          iconSize: 24,
          tabBackgroundColor: primarycolor.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.calendar,
              text: 'Jadwal',
            ),
            GButton(
              icon: LineIcons.file,
              text: 'Data',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profil',
            ),
          ],
          selectedIndex: selectedPosition,
          onTabChange: (index) {
            setState(() {
              selectedPosition = index;
            });
          },
        ),
      ),
    );
  }
}
