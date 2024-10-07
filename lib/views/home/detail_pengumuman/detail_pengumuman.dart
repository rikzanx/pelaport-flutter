import 'package:flutter/material.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/models/berita.dart';

class DetailPengumuman extends StatefulWidget {
  final int index;
  final Berita berita;
  const DetailPengumuman({Key? key, required this.index , required this.berita}) : super(key: key);

  @override
  _DetailPengumumanState createState() => _DetailPengumumanState();
}

class _DetailPengumumanState extends State<DetailPengumuman> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: primarycolor,
        ),
        elevation: 0,
        backgroundColor: secondarycolor,
        title: Text(
          "Berita",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: tinggilayar / 15,
                padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
                child: Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 30,
                        foregroundImage: NetworkImage(
                            widget.berita.link_foto_profil),
                      ),
                    ),
                    SizedBox(
                      width: lebarlayar / 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.berita.nama_publisher,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: tinggilayar / lebarlayar * 8),
                        ),
                        Text(
                          "2 m ago",
                          style:
                              TextStyle(fontSize: tinggilayar / lebarlayar * 5),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.87,
                minChildSize: 0.87,
                maxChildSize: 1,
                builder: (BuildContext context, listController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(),
                      controller: listController,
                      children: [
                        Container(
                          width: lebarlayar,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40)),
                            child: Hero(
                              tag: "gambar" + widget.index.toString(),
                              child: Image.network(
                                widget.berita.link_gambar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: marginhorizontal,
                              vertical: marginhorizontal),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.berita.judul,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: tinggilayar / lebarlayar * 10),
                              ),
                              SizedBox(
                                height: tinggilayar / 30,
                              ),
                              Text(
                                widget.berita.deskripsi,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: tinggilayar / lebarlayar * 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        height: tinggilayar / 1,
        width: lebarlayar,
        padding: EdgeInsets.symmetric(vertical: marginhorizontal),
      ),
    );
  }
}
