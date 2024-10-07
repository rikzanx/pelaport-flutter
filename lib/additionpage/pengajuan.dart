import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/lemburKhusus.dart';
import 'package:pelaport/additionpage/kehadiran.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/additionpage/detail/lembur.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/my_function.dart';

class Pengajuan extends StatefulWidget {
  const Pengajuan({Key? key}) : super(key: key);

  @override
  _PengajuanState createState() => _PengajuanState();
}

class _PengajuanState extends State<Pengajuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      appBar: AppBar(
        leading: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primarycolor,
        elevation: 0,
        title: Text(
          "Pengajuan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: tinggilayar,
        width: lebarlayar,
        child: SafeArea(
          child: Column(
            children: [
              CardFunction(
                asset: Image.asset(
                  "assets/tukarshift.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  // pindahPageCupertino(context, TukarShift());
                  MyFunction().belumTersedia();
                },
                judul: "Tukar Shift",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/lembur.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, Lembur());
                },
                judul: "Lembur SPL",
                deskripsi: "Ini Deksripsi",
              ),
              // SizedBox(
              //   height: tinggilayar / 40,
              // ),
              // CardFunction(
              //   asset: Image.asset(
              //     "assets/lembur.png",
              //     fit: BoxFit.cover,
              //   ),
              //   fungsi: () {
              //     pindahPageCupertino(context, LemburKhusus());
              //   },
              //   judul: "Lembur Khusus",
              //   deskripsi: "Ini Deksripsi",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
