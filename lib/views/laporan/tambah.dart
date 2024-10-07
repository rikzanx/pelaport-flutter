import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/apicontroller.dart';
// import 'package:pelaport/apiresponse.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/class/public_function.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/views/laporan/pencarian_parent.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image_picker/image_picker.dart';

class TambahLaporan extends StatefulWidget {
  const TambahLaporan({Key? key}) : super(key: key);

  @override
  _TambahLaporanState createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final judulController = TextEditingController();
  final dateController = TextEditingController();
  final kategoriController = TextEditingController();
  final prioritasController = TextEditingController();
  final zonaController = TextEditingController();
  final tanggalController = TextEditingController();
  final lokasiController = TextEditingController();
  final deskripsiController = TextEditingController();
  final kronologiController = TextEditingController();
  final akibatController = TextEditingController();
  final bantuanController = TextEditingController();
  int idKategori = 0;
  int idZona = 7;
  double lat = 0.0, lng = 0.0;

  List dataFoto = [];
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;
  // ignore: unused_field
  dynamic _pickImageError;

  Future getImage() async {
    try {
      final pickedFileList = await _picker.pickMultiImage(
        imageQuality: 40,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });

      print(_imageFileList);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future datepicker() async {
    final DateTime? tgl = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (tgl != null) {
      dateController.text = tgl.toString().substring(0, 10);
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Tambah Laporan"),
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  myContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Judul"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        controller: judulController,
                        placeholder: "Masukkan Judul",
                        isRequired: true,
                      )
                    ],
                  )),
                  SizedBox(
                    height: 16,
                  ),
                  myContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Kategori"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                          onTap: getKategori,
                          isDropdown: true,
                          isRequired: true,
                          controller: kategoriController,
                          placeholder: "Kategori"),
                      SizedBox(
                        height: 8,
                      ),
                      label("Prioritas"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                          onTap: getPrioritas,
                          isDropdown: true,
                          isRequired: true,
                          controller: prioritasController,
                          placeholder: "Prioritas"),
                      SizedBox(
                        height: 8,
                      ),
                      label("Lokasi"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        isReadonly: true,
                        controller: lokasiController,
                        placeholder: "Lokasi",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 300,
                        child: lat == 0.0
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : WebView(
                                initialUrl:
                                    'http://$baseUrl/maps/android?lat=$lat&lng=$lng',
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
                      ),
                      label("Zona"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                          onTap: getZona,
                          isDropdown: true,
                          isRequired: true,
                          controller: zonaController,
                          placeholder: "Zona"),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 32,
                  ),
                  myContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Kronologi Kejadian"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        isLongText: true,
                        controller: kronologiController,
                        placeholder: "Masukkan Kronologi Kejadian",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      label("Akibat Kejadian"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        isLongText: true,
                        controller: akibatController,
                        placeholder: "Masukkan Akibat Kejadian",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      label("Bantuan Pengamanan"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        isLongText: true,
                        controller: bantuanController,
                        placeholder: "Masukkan Bantuan Pengamanan",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      label("Tanggal Kejadian"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                        controller: dateController,
                        isDatePicker: true,
                        isReadonly: true,
                        placeholder: "Pilih Tanggal",
                        isRequired: true,
                        onTap: datepicker,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 16,
                  ),
                  myContainer(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            label("Foto Laporan"),
                            IconButton(
                                onPressed: () {
                                  getImage();
                                },
                                icon: Icon(CupertinoIcons.photo_camera))
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        _imageFileList != null
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),

                                ///
                                shrinkWrap: true,
                                itemCount: _imageFileList!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      width: 256,
                                      height: 256,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(_imageFileList![i].path)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container()
                      ])),
                  SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    warna: secondarycolor,
                    teksnya: "SIMPAN LAPORAN",
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        save();
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future init() async {
    await ApiController().getCurrentLocation().then((value) {
      print(value);
      if (mounted)
        setState(() {
          lat = value.latitude;
          lng = value.longitude;
          lokasiController.text = lat.toString() + ", " + lng.toString();
        });
    });
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget myContainer(Widget append) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Padding(padding: EdgeInsets.all(16), child: append),
    );
  }

  Future save() async {
    List<String> fotoBase64 = [];
    for (int i = 0; i < _imageFileList!.length; i++) {
      String base64 = await PublicFunction()
          .convertImageToBase64(File(_imageFileList![i].path));
      fotoBase64.add(base64);
    }

    BotToast.showLoading(
        clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'nik': dataUser['karyawan']['nik'].toString(),
      'id_departemen': dataUser['karyawan']['user']['id_departemen'].toString(),
      'judul_laporan': judulController.text.toString(), //string
      'id_kategori': idKategori.toString(), //int
      'prioritas': prioritasController.text.toString(), //string
      'lat': lat.toString(),
      'lng': lng.toString(),
      'id_zona': idZona.toString(),
      'tgl_waktu_kejadian': dateController.text,
      'kronologi_kejadian': kronologiController.text,
      'akibat_kejadian': akibatController.text,
      'bantuan_pengamanan': bantuanController.text,
      'foto': jsonEncode(fotoBase64)
    };

    await ApiController().laporanStore(body).then((response) {
      if (response.data['success']) {
        BotToast.closeAllLoading();
        Navigator.pop(context);
        BotToast.showText(
            text: response.data['message'].toString(),
            crossPage: true,
            textStyle: TextStyle(fontSize: 14, color: Colors.white),
            contentColor: Colors.green);
      } else {
        BotToast.closeAllLoading();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(response.data['message'].toString()),
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

  Future getKategori() async {
    final result = await pindahPageCupertinoResult(
        context, PencarianParent(tipe: "kategori"));

    if (result != null) {
      if (mounted)
        setState(() {
          kategoriController.text = result['nama_kategori'];
          idKategori = result['id_kategori'];
        });
    }
  }

  Future getPrioritas() async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PencarianParent(tipe: "prioritas");
    }));

    if (result != null) {
      if (mounted)
        setState(() {
          prioritasController.text = result;
        });
    }
  }

  Future getZona() async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PencarianParent(tipe: "zona");
    }));

    if (result != null) {
      if (mounted)
        setState(() {
          zonaController.text = result["nama_zona"];
          idZona = result["id_zona"];
        });
    }
  }
}
