import 'package:flutter/material.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/home.dart';
import 'package:pelaport/views/home/detail_laporan/detail_laporan.dart';

class Cari extends StatefulWidget {
  const Cari({Key? key}) : super(key: key);

  @override
  _CariState createState() => _CariState();
}

class _CariState extends State<Cari> {
  TextEditingController _cariController = new TextEditingController();
  bool cari = false;

  bool hasilkategori = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map> kategori = List.generate(
        10, (index) => {"id": index, "kategori": "Kategori $index"});

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: tinggilayar / 50),
            height: tinggilayar,
            width: lebarlayar,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Pencarian",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primarycolor,
                        fontSize: tinggilayar / lebarlayar * 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(marginhorizontal),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: EdgeInsets.all(0.5),
                  child: TextField(
                    onChanged: (val) {
                      if (val == "") {
                        setState(() {
                          cari = false;
                          hasilkategori = false;
                        });
                      } else {
                        setState(() {
                          cari = true;
                          hasilkategori = false;
                        });
                      }
                    },
                    controller: _cariController,
                    decoration: InputDecoration(
                      hintText: "Cari Laporan",
                      suffixIcon: Icon(
                        Icons.search,
                        color: primarycolor,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                hasilkategori == false
                    ? Container(
                        height: tinggilayar / 1.54,
                        child: cari == false
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(
                                  vertical: marginhorizontal,
                                  horizontal: marginhorizontal,
                                ),
                                itemCount: kategori.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 2 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(hasilkategori);
                                      setState(() {
                                        hasilkategori = true;
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              child: Text(
                                                kategori[index]["kategori"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              width: double.infinity,
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                "https://hsepedia.com/wp-content/uploads/2020/03/ICON_HSE_SOLID.png",
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container(),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: lebarlayar / 30),
                        height: tinggilayar / 1.54,
                        child: ListView.builder(
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                // pindahPageCupertino(
                                //     context, DetailLaporan(index: i));
                              },
                              child: CardWithImage(
                                index: i.toString(),
                                title: "Buat Judul Laporan",
                                deskripsi:
                                    "Deskripsi dari laporan penjelas dari kegiatan atau hasil approval dari beberapa stakeholder",
                                publisher: "Admin",
                                image:
                                    "https://img.okezone.com/content/2019/07/28/320/2084629/petrokimia-gresik-buka-lowongan-kerja-sebagai-pahlawan-solusi-agroindustri-TVETDvYDBK.png",
                              ),
                            );
                          },
                          itemCount: 10,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
