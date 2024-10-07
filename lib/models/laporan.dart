// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:pelaport/constant.dart';
class Laporan extends Equatable {
  final String id_laporan;
  final String nik;
  final String id_departemen;
  final String judul_laporan;
  final String id_kategori;
  final String prioritas;
  final String tingkat;
  final String appv1;
  final String appv2;
  final String appv3;
  final String publish;
  final String lat;
  final String lng;
  final String id_zona;
  final String unit_kerja;
  final DateTime tgl_waktu_kejadian;
  final String kronologi_kejadian;
  final String akibat_kejadian;
  final String bantuan_pengamanan;
  final DateTime created_at;
  final String link_foto;
  final String nama_publisher;
  final String link_foto_profil;

  Laporan({
    required this.id_laporan,
    required this.nik,
    required this.id_departemen,
    required this.judul_laporan,
    required this.id_kategori,
    required this.prioritas,
    required this.tingkat,
    required this.appv1,
    required this.appv2,
    required this.appv3,
    required this.publish,
    required this.lat,
    required this.lng,
    required this.id_zona,
    required this.unit_kerja,
    required this.tgl_waktu_kejadian,
    required this.kronologi_kejadian,
    required this.akibat_kejadian,
    required this.bantuan_pengamanan,
    required this.created_at,
    required this.link_foto,
    required this.nama_publisher,
  required this.link_foto_profil,
  });

  @override
  List<Object?> get props => [id_laporan];

  factory Laporan.fromJson(Map<String, dynamic> json){
    return Laporan(
        id_laporan          :json['id_laporan'].toString(),
        nik                 :json['nik'].toString(),
        id_departemen       :json['id_departemen'].toString(),
        judul_laporan       :json['judul_laporan'].toString(),
        id_kategori         :json['id_kategori'].toString(),
        prioritas           :json['prioritas'].toString(),
        tingkat             :json['tingkat'].toString(),
        appv1               :(json['appv1'] != null)? json['appv1'].toString() : '',
        appv2               :(json['appv2'] != null)? json['appv2'].toString() : '',
        appv3               :(json['appv3'] != null)? json['appv3'].toString() : '',
        publish             :json['publish'].toString(),
        lat                 :json['lat'].toString(),
        lng                 :json['lng'].toString(),
        id_zona             :json['id_zona'].toString(),
        unit_kerja          :(json['unit_kerja'] != null)? json['unit_kerja'].toString() : '',
        tgl_waktu_kejadian  :DateTime.parse(json['tgl_waktu_kejadian'].toString()),
        kronologi_kejadian  :(json['kronologi_kejadian'] != null)? json['kronologi_kejadian'].toString() : '',
        akibat_kejadian     :(json['akibat_kejadian'] != null)? json['akibat_kejadian'].toString() : '',
        bantuan_pengamanan  :(json['bantuan_pengamanan'] != null)? json['bantuan_pengamanan'].toString() : '',
        created_at          :DateTime.parse(json['created_at'].toString()),
        link_foto           :protokol+baseUrl+"/foto/laporan"+json['laporan_bukti']['foto'].toString(),
        link_foto_profil    :protokol+baseUrl+"/assets/foto_profil/"+json['user']['foto'].toString() ,
        nama_publisher      :json['user']['karyawan']['nama_lengkap'].toString(),
    );
  }
}