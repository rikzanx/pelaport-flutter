// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Jadwal extends Equatable {
  final String id_jadwal;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String pattern_number;
  final String jam_masuk;
  final String jam_keluar;
  final String action;

  Jadwal({
    required this.id_jadwal,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.pattern_number,
    required this.jam_masuk,
    required this.jam_keluar,
    required this.action,
  });

  @override
  List<Object?> get props => [id_jadwal];

  factory Jadwal.fromJson(Map<String, dynamic> json){
    return Jadwal(
      id_jadwal: json['id_jadwal'].toString(),
      tanggal:json['tanggal'].toString(),
      bulan:json['bulan'].toString(),
      tahun:json['tahun'].toString(),
      pattern_number:json['pattern_number'].toString(),
      jam_masuk:json['jam_masuk'].toString(),
      jam_keluar:json['jam_keluar'].toString(),
      action: json['action'].toString()
    );
  }
}