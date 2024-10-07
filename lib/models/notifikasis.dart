// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
class Notifikasis extends Equatable {
  final String id_notifikasi;
  final String kategori_notifikasi;
  final String judul_notifikasi;
  final String isi_notifikasi;
  final DateTime created_at;

  Notifikasis({
    required this.id_notifikasi,
    required this.kategori_notifikasi,
    required this.judul_notifikasi,
    required this.isi_notifikasi,
    required this.created_at
  });

  @override
  List<Object?> get props => [id_notifikasi];

  factory Notifikasis.fromJson(Map<String, dynamic> json){
    return Notifikasis(
      id_notifikasi: json['id_notifikasi'].toString(),
      kategori_notifikasi: json['kategori_notifikasi'].toString(),
      judul_notifikasi: json['judul_notifikasi'].toString(),
      isi_notifikasi: json['isi_notifikasi'].toString(),
      created_at: DateTime.parse(json['created_at'].toString()),
      
    );
  }
}