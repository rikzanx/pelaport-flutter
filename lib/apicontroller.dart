// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';
import 'package:pelaport/constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:pelaport/apiresponse.dart';

class ApiController {
  late Response response;
  var dio = Dio();

  Future connection({String method = "get",String path = "" ,var parameter , Map<String, String>? body}) async {
    Uri url;
    BotToast.showLoading();
    // if (protokol == 'https://')
    //   url = Uri.https(baseUrl, "api/" + path);
    // else
    url = Uri.http(baseUrl, "api/" + path,parameter);
    var res;
    if (method == "get") {
      final res = await http.get(url);
      print(url);
      try{
        if(res.statusCode == StatusCode.OK){
          var data = jsonDecode(res.body);
          print(data);

          BotToast.closeAllLoading();
          return ApiResponse<dynamic>(true, data:data);
        }else{
          print(res.body);
          print(url);
          var data = jsonDecode(res.body);
          BotToast.closeAllLoading();
          return ApiResponse<dynamic>(false, message: "tidak bisa daftar",data: data);
        }

      }catch($e){
        print($e);
        BotToast.closeAllLoading();
        return ApiResponse(false, message: defaultErrorText);
      }
    } else {
      res = await http.post(url, body: body);
      print(body);
      try{
        if(res.statusCode == StatusCode.OK ){
          // print("iki;lo");
          var data = jsonDecode(res.body);
          BotToast.closeAllLoading();
          return ApiResponse<dynamic>(true, data:data);
        }else if(res.statusCode == StatusCode.CREATED){
          var data = jsonDecode(res.body);
          BotToast.closeAllLoading();
          return ApiResponse<dynamic>(true, data:data);
        }else if(res.statusCode == StatusCode.UNAUTHORIZED){
          var data = jsonDecode(res.body);
          BotToast.closeAllLoading();
          print("padahal iki");
          return ApiResponse<dynamic>(false, data:data);
        }else{
          print(res.body);
          print(url);
          var data = jsonDecode(res.body);
          BotToast.closeAllLoading();
          return ApiResponse<dynamic>(false, message: "tidak bisa daftar",data: data);
          // BotToast.closeAllLoading();
          // return ApiResponse<String>(false, message: "tidak bisa daftar");
        }

      }catch($e){
        print($e);
        BotToast.closeAllLoading();
        return ApiResponse(false, message: defaultErrorText);
      }
    }

    
  }

  Future pencarianParent() async {
    // final response = await http.get(url);
    return await connection(method: "get", path: "laporan/create");
  }

  Future laporanStore(Map<String, String> body) async {
    return await connection(method: 'post', path: "laporan", body: body);
  }

  Future login(Map<String, String> body) async {
    return await connection(method: 'post', path: "login", body: body);
  }

  Future checklistPresensi(Map<String, String> body) async {
    return await connection(
        method: 'post', path: "user/checklist_presensi", body: body);
  }

  Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idregu = prefs.getString('id_regu');
    var idKar = prefs.getString('id_karyawan');
    return await connection(method: 'get', path: 'user/get_user',parameter: {'id_karyawan': idKar, 'id_regu': idregu});
  }

  Future changePassword(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/change_password", body: body);
  }

  Future checkin(var body) async {
    return await connection(method: 'post',path: 'user/checkin', body: body);
  }

  Future checkout({required String id_presensi}) async {

    var body = {'id_presensi': id_presensi};

    return await connection(method: 'post',path: 'user/checkout', body: body);
  }

  Future getJamMasuk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    return await connection(method: 'post',path: 'user/checklist_jammasuk',parameter:{'nik':nik.toString()});

    // return await connection(
    //     method: "get", path: "user/get_user?id_karyawan=447&id_regu=2");
  }

  Future ijinSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();

    return await connection(
        method: 'post', path: "user/ijin_submit", body: body);
  }

  Future dispensasiSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/dispensasi_submit", body: body);
  }

  Future sakitSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/sakit_submit", body: body);
  }

  Future cutiSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/cuti_submit", body: body);
  }

  Future lemburSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/lembur_submit", body: body);
  }

  Future lemburkhususSubmit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/lemburkhusus_submit", body: body);
  }

  Future lemburEdit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/lembur_edit", body: body);
  }

  Future lemburkhususEdit(Map<String, String> body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nik = prefs.getString('nik');
    body['nik'] = nik.toString();
    return await connection(
        method: 'post', path: "user/lemburkhusus_edit", body: body);
  }

  Future getJadwal(Map<String,String> body) async{
    return await connection(method: 'get',path: "user/get_jadwal",parameter: body);
  }

  Future getDataAbsen(Map<String, String> body) async{
    return await connection(method: 'get',path: "user/list_absen",parameter: body);
  }
  Future getDataLembur(Map<String, String> body) async{
    return await connection(method: 'get',path: "user/list_lembur",parameter: body);
  }
  Future getDataLemburKhusus(Map<String, String> body) async{
    return await connection(method: 'get',path: "user/list_lembur_khusus",parameter: body);
  }
  Future getDataNotifikasi(Map<String, String> body) async{
    return await connection(method: 'get',path: "user/notifikasi",parameter: body);
  }
  Future getDataMyLaporan(Map<String, String> body) async{
    return await connection(method: 'get',path: "laporan/by_user",parameter: body);
  }
  Future getDataAllLaporan() async{
    return await connection(method: 'get',path: "laporan/all");
  }
  Future getStatusLaporan(Map<String, String> body) async{
    return await connection(method: 'get',path: "laporan/status",parameter: body);
  }
  Future getDataBerita() async{
    return await connection(method: 'get',path: "berita");
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
