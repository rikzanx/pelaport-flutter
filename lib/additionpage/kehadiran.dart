import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/presensi.dart';
import 'package:pelaport/additionpage/detail/presensiKeluar.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/my_function.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({Key? key}) : super(key: key);

  @override
  _KehadiranState createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {
  bool cekIn = false, cekOut = false, cekOutMessage = false;
  String jamKeluar = "";
  @override
  void initState() {
    super.initState();

    init();
  }

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
          "Kehadiran",
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
                  "assets/masukk.png",
                  fit: BoxFit.cover,
                  color: !cekIn ? Colors.grey : null,
                ),
                fungsi: !cekIn
                    ? () {}
                    : () async {
                        var result = await pindahPageCupertinoResult(
                            context, PresensiMasuk());

                        if (result != null) init();
                      },
                disable: !cekIn,
                judul: "Presensi Masuk",
                deskripsi: "Wajib mengisi presensi masuk",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/keluar.png",
                  fit: BoxFit.cover,
                  color: cekOut == false ? Colors.grey : null,
                ),
                fungsi: cekOut == false
                    ? () {}
                    : () async {
                        var result = await pindahPageCupertinoResult(
                            context, PresensiKeluar());

                        if (result != null) init();
                      },
                disable: cekOut == false,
                judul: "Presensi Keluar",
                deskripsi: "Wajib mengisi presensi keluar",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              (cekOutMessage)
                  ? Text(
                      "Anda bisa checkout pada saat jam " + jamKeluar,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: tinggilayar / lebarlayar * 6),
                    )
                  : SizedBox(
                      height: tinggilayar / 40,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  init() async {
    String nik = await MyFunction().getNik();
    print('$nik');
    await ApiController().checklistPresensi({"nik": nik}).then((response) {
      var value = response.data;
      BotToast.closeAllLoading();

      if (mounted)
        setState(() {
          cekIn = value['checkin'];
          cekOut = value['checkout'];
          cekOutMessage = value["checkout_message"];
          jamKeluar = value["jam_keluar"];
          print('$cekIn = $cekOut = $nik');
        });
    });
  }
}

class CardFunction extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final Image asset;
  final VoidCallback fungsi;
  final bool disable;
  const CardFunction(
      {Key? key,
      required this.asset,
      required this.fungsi,
      required this.judul,
      this.disable = false,
      required this.deskripsi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fungsi,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
        child: Row(
          children: [
            Container(
                height: tinggilayar / 8, width: lebarlayar / 4, child: asset),
            SizedBox(
              width: lebarlayar / 15,
            ),
            Expanded(
              child: Text(
                judul,
                style: TextStyle(
                    color: disable ? Colors.grey : primarycolor,
                    fontSize: tinggilayar / lebarlayar * 9,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        height: tinggilayar / 8,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 3,
              blurRadius: 10,
              color: Color(0xffEFEFEF),
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
