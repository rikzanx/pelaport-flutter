import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/kehadiran.dart';
import 'package:pelaport/additionpage/detail/ijin.dart';
import 'package:pelaport/additionpage/detail/dispensasi.dart';
import 'package:pelaport/additionpage/detail/sakit.dart';
import 'package:pelaport/additionpage/detail/cuti.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';

class Absen extends StatefulWidget {
  const Absen({Key? key}) : super(key: key);

  @override
  _AbsenState createState() => _AbsenState();
}

class _AbsenState extends State<Absen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondarycolor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: primarycolor,
        elevation: 0,
        title: Text(
          "Absen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CardFunction(
                asset: Image.asset(
                  "assets/ijin.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, Ijin());
                },
                judul: "Ijin",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/absen.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, Dispensasi());
                },
                judul: "Dispensasi",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/sakit.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, Sakit());
                },
                judul: "Sakit",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/cuti.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, Cuti());
                },
                judul: "Cuti",
                deskripsi: "Ini Deksripsi",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
