import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/list_data_detail/list_absen.dart';
import 'package:pelaport/additionpage/list_data_detail/list_lembur.dart';
import 'package:pelaport/additionpage/list_data_detail/list_lembur_khusus.dart';
import 'package:pelaport/additionpage/list_data_detail/list_presensi.dart';
import 'package:pelaport/additionpage/list_data_detail/penilaian_kinerja.dart';
import 'package:pelaport/additionpage/list_data_detail/slip_gaji.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';

class ListData extends StatefulWidget {
  const ListData({Key? key}) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Data',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              SizedBox(
                height: tinggilayar / 40,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/presensi.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  // MyFunction().belumTersedia();
                  pindahPageCupertino(context, ListPresensi());
                },
                judul: "List Presensi",
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
                  pindahPageCupertino(context, ListAbsen());
                  // MyFunction().belumTersedia();
                },
                judul: "List Absen",
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
                  pindahPageCupertino(context, ListLembur());
                  // MyFunction().belumTersedia();
                },
                judul: "List Lembur",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/gaji.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, SlipGaji());
                  // MyFunction().belumTersedia();
                },
                judul: "Slip Gaji",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
              CardFunction(
                asset: Image.asset(
                  "assets/penilaiankinerja.png",
                  fit: BoxFit.cover,
                ),
                fungsi: () {
                  pindahPageCupertino(context, PenilaianKinerja());
                  // MyFunction().belumTersedia();
                },
                judul: "Penilaian Kinerja",
                deskripsi: "Ini Deksripsi",
              ),
              SizedBox(
                height: tinggilayar / 80,
              ),
            ],
          ),
        ),
      ),
    );
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
                padding: EdgeInsets.all(15),
                height: tinggilayar / 8,
                width: lebarlayar / 4,
                child: asset),
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
