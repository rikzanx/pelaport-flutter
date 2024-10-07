import 'package:flutter/material.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:pelaport/views/notifikasi/notifikasi.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pelaport/additionpage/kehadiran.dart';
import 'package:pelaport/additionpage/absen.dart';
import 'package:pelaport/additionpage/pengajuan.dart';
import 'package:pelaport/views/laporan/tambah.dart';
import 'package:pelaport/models/berita.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/views/schedule/utils.dart';
import 'package:pelaport/models/laporan.dart';
import 'package:pelaport/views/home/detail_laporan/detail_laporan.dart';
import 'package:pelaport/views/home/detail_pengumuman/detail_pengumuman.dart';

class Homekah extends StatefulWidget {
  const Homekah({Key? key}) : super(key: key);

  @override
  _HomekahState createState() => _HomekahState();
}

class _HomekahState extends State<Homekah> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 0.0,
          top: -20.0,
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              'assets/home_background.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              homeSection(),
              const SizedBox(
                height: 50.0,
              ),
              ContentSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget customCard(
      {required String imagePath,
      required String title,
      TextStyle? titleTextStyle}) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                child: Image.asset(
                  imagePath,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: titleTextStyle,
        ),
      ],
    );
  }

  Widget homeSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      text: "Halo,\n",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          color: Colors.white
                          // Add any additional text style properties if needed
                          ),
                      children: [
                        TextSpan(
                          text: dataUser['karyawan']['nama_lengkap'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //action coe when button is pressed
                    pindahPageCupertino(context, Notifikasi());
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  Widget customCard(
      {required String imagePath,
      required String title,
      TextStyle? titleTextStyle}) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                child: Image.asset(
                  imagePath,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            // Add any additional text style properties if needed
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Color.fromARGB(255, 255, 253, 248),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        pindahPageCupertino(context, Kehadiran());
                      },
                      child: customCard(
                        imagePath: 'assets/hadir.png',
                        title: 'Kehadiran',
                        titleTextStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pindahPageCupertino(context, Absen());
                      },
                      child: customCard(
                        imagePath: 'assets/absen.png',
                        title: 'Absen',
                        titleTextStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pindahPageCupertino(context, Pengajuan());
                      },
                      child: customCard(
                        imagePath: 'assets/pengajuan.png',
                        title: 'Pengajuan',
                        titleTextStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pindahPageCupertino(context, TambahLaporan());
                      },
                      child: customCard(
                        imagePath: 'assets/laporan.png',
                        title: 'Laporan',
                        titleTextStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: tinggilayar / 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
            width: lebarlayar,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Berita",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tinggilayar / lebarlayar * 8),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: tinggilayar / 50),
            height: tinggilayar / 3.8,
            width: lebarlayar,
            child: FutureBuilder<List<Berita>>(
              future: fetchDataBerita(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Berita>? data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext) => DetailPengumuman(
                                        index: i,
                                        berita: data[i],
                                      )));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  child: Hero(
                                    tag: "gambar" + i.toString(),
                                    child: Image.network(
                                      data[i].link_gambar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: tinggilayar / 6,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    top: lebarlayar / 50,
                                    left: lebarlayar / 30,
                                    right: lebarlayar / 30),
                                child: Text(
                                  listBerita[i].judul,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: tinggilayar / lebarlayar * 6.5),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: lebarlayar / 30,
                                    top: lebarlayar / 50,
                                    right: lebarlayar / 30),
                                child: Text(
                                  data[i].deskripsi,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: tinggilayar / lebarlayar * 5.5),
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(right: lebarlayar / 20),
                          width: lebarlayar / 1.35,
                          height: tinggilayar / 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  color: Colors.grey.shade300)
                            ],
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                        left: lebarlayar / 20, bottom: tinggilayar / 50),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return SizedBox(
                  height: tinggilayar / 10,
                  width: tinggilayar / 10,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
            width: lebarlayar,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lokasi Saat Ini",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tinggilayar / lebarlayar * 8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: tinggilayar / 1000,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent, // Set border color to transparent
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color
                    spreadRadius: 2, // Set the spread radius
                    blurRadius: 2, // Set the blur radius
                    offset: Offset(0, 3), // Offset of the shadow
                  ),
                ],
              ),
              child: WebView(
                initialUrl: 'http://$baseUrl/maps/android/absen',
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (int progress) {
                  print("MyLog WebView is loading (progress : $progress%)");
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('MyLog Page finished loading: $url');
                },
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                ].toSet(),
              ),
            ),
          ),
          SizedBox(
            height: tinggilayar / 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: lebarlayar / 20),
            width: lebarlayar,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Laporan Terbaru",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tinggilayar / lebarlayar * 8),
                ),
              ],
            ),
          ),
          SizedBox(
            height: tinggilayar / 50,
          ),
          Container(
            height: tinggilayar / 4,
            child: FutureBuilder<List<Laporan>>(
                future: fetchAllLaporan(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Laporan> data = snapshot.data!;
                    return ListView.builder(
                        // scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(bottom: tinggilayar / 15),
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              pindahPageCupertino(context,
                                  DetailLaporan(index: i, laporan: data[i]));
                            },
                            child: CardWithImage(
                              index: i.toString(),
                              title: data[i].judul_laporan,
                              deskripsi: data[i].kronologi_kejadian,
                              publisher: "Admin",
                              image: data[i].link_foto,
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return SizedBox(
                    height: tinggilayar / 10,
                    width: tinggilayar / 10,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Future<List<Berita>> fetchDataBerita() async {
  var response = await ApiController().getDataBerita();
  List<Berita> beritaList = new List.empty(growable: true);
  var jsonlist = response.data as List;
  jsonlist.forEach((element) {
    beritaList.add(Berita.fromJson(element));
  });
  listBerita = beritaList;
  return beritaList;
  // return notifikasiList;
}

Future<List<Laporan>> fetchAllLaporan() async {
  var response = await ApiController().getDataAllLaporan();
  List<Laporan> beritaList = new List.empty(growable: true);
  var jsonlist = response.data as List;
  jsonlist.forEach((element) {
    beritaList.add(Laporan.fromJson(element));
  });
  return beritaList;
  // return notifikasiList;
}

class CardWithImage extends StatelessWidget {
  final String? title;
  final String? deskripsi;
  final String? publisher;
  final String? image;
  final String? index;
  final VoidCallback? onTap;

  const CardWithImage(
      {Key? key,
      this.index,
      this.onTap,
      this.title,
      this.deskripsi,
      this.publisher,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 1,
                blurRadius: 3,
                color: Colors.grey.shade300),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: tinggilayar / 5,
              width: lebarlayar / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: "gmbr" + index!,
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: lebarlayar / 50,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(lebarlayar / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                          color: primarycolor,
                          fontSize: tinggilayar / lebarlayar * 7,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      deskripsi!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: tinggilayar / lebarlayar * 5),
                    ),
                    Text(
                      "Publisher by: " + publisher!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: tinggilayar / lebarlayar * 4,
                          color: Colors.grey[500]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        margin: EdgeInsets.only(
            bottom: tinggilayar / 50,
            left: lebarlayar / 20,
            right: lebarlayar / 20),
        height: tinggilayar / 8,
        width: lebarlayar,
      ),
    );
  }
}
