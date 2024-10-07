import 'package:flutter/material.dart';

class Slide {
  final String? imageUrl;
  final String? title;
  final String? gambar;
  final String? description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.gambar,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: '',
    title: 'PELAPORAN',
    gambar: 'assets/images/slide1.png',
    description:
        'Dapat melaporkan sebuah kejadian kapanpun dan dimanapun anda berada secara real time. Segala bentuk pelaporan dapat diakses melalui aplikasi',
  ),
  Slide(
    imageUrl: '',
    title: 'PEMANTAUAN',
    gambar: 'assets/images/slide2.png',
    description:
        'Semua elemen dapat melihat dan memantau kinerja pribadi karyawan serta kejadian keamanan yang ada pada perusahaan',
  ),
  Slide(
    imageUrl: '',
    title: 'MUDAH DIGUNAKAN',
    gambar: 'assets/images/slide3.png',
    description:
        'Mudah digunakan dan efisien dalam penerapannya. Anda tidak perlu terlalu bingung dalam menggunakan aplikasi ini',
  ),
];
