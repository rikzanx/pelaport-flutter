// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:pelaport/constant.dart';
class Berita extends Equatable {
  final String id_berita;
  final String judul;
  final String deskripsi;
  final String link_gambar;
  final DateTime created_at;
  final String nama_publisher;
  final String link_foto_profil;

  Berita({
    required this.id_berita,
    required this.judul,
    required this.deskripsi,
    required this.link_gambar,
    required this.created_at,
    required this.nama_publisher,
    required this.link_foto_profil
  });

  @override
  List<Object?> get props => [id_berita];

  factory Berita.fromJson(Map<String, dynamic> json){
    return Berita(
        id_berita           :json['id_berita'].toString(),
        judul               :json['judul'].toString(),
        deskripsi           :json['deskripsi'].toString(),
        link_gambar         :protokol+baseUrl+"/assets/gambar_berita/"+json['gambar'].toString() ,
        link_foto_profil    :protokol+baseUrl+"/assets/foto_profil/"+json['user']['foto'].toString() ,
        nama_publisher      :json['user']['karyawan']['nama_lengkap'].toString(),
        created_at          :DateTime.parse(json['created_at'].toString()),
    );
  }
}