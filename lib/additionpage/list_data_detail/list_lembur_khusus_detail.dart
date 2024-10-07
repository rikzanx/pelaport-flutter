import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/lemburEdit.dart';
import 'package:pelaport/additionpage/detail/lemburKhususEdit.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/constant.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/my_function.dart';

class ListLemburKhususDetail extends StatefulWidget {
  final String tipe;
  final String nik;
  final String judul;
  const ListLemburKhususDetail(
      {Key? key, required this.tipe, required this.nik, required this.judul})
      : super(key: key);

  @override
  _ListLemburKhususDetailState createState() => _ListLemburKhususDetailState();
}

class _ListLemburKhususDetailState extends State<ListLemburKhususDetail> {
  // ignore: unused_field
  String _nik = '';
  // ignore: unused_field
  String _tipe = '0';
  String _judul = '';
  int position = 1;
  List<dynamic> _dataLemburKhusus = [];
  @override
  void initState() {
    // init();
    _getDataLemburKhusus(widget.tipe.toString(), widget.nik);
    _tipe = widget.tipe;
    _nik = widget.nik;
    _judul = widget.judul;
    super.initState();
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
          "List Lembur Khusus",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("$_judul"),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: _createDataTable()),
          ),
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      showBottomBorder: true,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('No')),
      DataColumn(label: Text('Tgl LemburKhusus')),
      DataColumn(label: Text('Jenis LemburKhusus')),
      DataColumn(label: Text('Mulai')),
      DataColumn(label: Text('Selesai')),
      DataColumn(label: Text('NIK')),
      DataColumn(label: Text('Nama')),
      DataColumn(label: Text('Kajaga')),
      DataColumn(label: Text('Aksi')),
    ];
  }

  List<DataRow> _createRows() {
    if (_dataLemburKhusus.length > 0) {
      int num = 0;
      return _dataLemburKhusus.map((data) {
        num++;
        return DataRow(cells: [
          DataCell(Text(num.toString())),
          DataCell(Text(data['tgl_lembur_khusus'].toString())),
          DataCell(Text(data['jenis_lembur_khusus'].toString())),
          DataCell(Text(data['mulai'].toString())),
          DataCell(Text(data['selesai'].toString())),
          DataCell(Text(data['nik'])),
          DataCell(Text(data['karyawan']['nama_lengkap'])),
          DataCell(Text("")),
          DataCell(GestureDetector(
            onTap: () {
              Navigator.pop(context);
              pindahPageCupertino(
                  context,
                  LemburKhususEdit(
                    id_lembur_khusus: data['id_lembur_khusus'].toString(),
                    jenisLemburKhusus: data['jenis_lembur_khusus'].toString(),
                    tglLemburKhusus: data['tgl_lembur_khusus'].toString(),
                    mulai: data['mulai'].toString().substring(0, 5),
                    selesai: data['selesai'].toString().substring(0, 5),
                  ));
            },
            child: new Text(
              "Edit",
            ),
          ))
        ]);
      }).toList();
    } else {
      return [
        DataRow(cells: [
          DataCell(Text('Data Tidak ada')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text(''))
        ]),
      ];
    }
  }

  init() async {
    String nik = await MyFunction().getNik();
    print('$nik');
    setState(() {
      _nik = nik;
      _tipe = widget.tipe;
    });
  }

  Future _getDataLemburKhusus(String tipe, String nik) async {
    Map<String, String> body = {'tipe': tipe, 'nik': nik};
    var response = await ApiController().getDataLemburKhusus(body);
    if (response.status) {
      if (response.data.length > 0) {
        // print(response.data.isList);
        setState(() {
          _dataLemburKhusus = response.data;
        });
      }
    }
  }
}
