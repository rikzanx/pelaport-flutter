import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/presensi.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/constant.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/views/laporan/pencarian_parent.dart';


class LemburKhusus extends StatefulWidget {
  const LemburKhusus({Key? key}) : super(key: key);

  @override
  _LemburKhususState createState() => _LemburKhususState();
}

class _LemburKhususState extends State<LemburKhusus> {
  final dateController = TextEditingController();
  final deskripsiController = TextEditingController();
  final timeMulaiController = TextEditingController();
  final timeSelesaiController = TextEditingController();
  final jenisLemburKhususController = TextEditingController();

  int _currentHorizontalIntValue = 1;

  Future timemulai() async{
    final TimeOfDay? timeMulai = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(DateTime.now())
      );

    if(timeMulai != null){
      timeMulaiController.text = timeMulai.format(context);
      print(timeMulai.format(context));
    }
  }

  Future timeselesai() async{
    final TimeOfDay? timeSelesai = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1, minutes: 0, seconds: 0)))
      );

    if(timeSelesai != null){
      timeSelesaiController.text = timeSelesai.format(context);
      print(timeSelesai.toString());
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
    init();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: primarycolor,
            ),
          ),
        ),
        title: Text(
          "Form Lembur Khusus",
          style: TextStyle(color: primarycolor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InfoUser(),
            SizedBox(
              height: 20,
            ),
            myContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Jenis Lembur Khusus"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                          onTap: getJenisLemburKhusus,
                          isDropdown: true,
                          isRequired: true,
                          controller: jenisLemburKhususController,
                          placeholder: "Jenis"),
                    ]
            )),
            SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Lembur Khusus"),
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
                )
              ],
            )),
            SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Jam mulai lembur khusus"),
                SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: timeMulaiController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Jam",
                  isRequired: true,
                  onTap: timemulai,
                )
              ],
            )),
            SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Jam selesai lembur khusus"),
                SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: timeSelesaiController,
                  isDatePicker: true,
                  isReadonly: true,
                  placeholder: "Pilih Jam",
                  isRequired: true,
                  onTap: timeselesai,
                )
              ],
            )),
            SizedBox(
              height: 16,
            ),
            myContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label("Deskripsi"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    isLongText: true,
                    controller: deskripsiController,
                    placeholder: "Masukkan Deskripsi",
                    isRequired: true,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            PrimaryButton(
              warna: Colors.white,
              onClick: () {
                save();
              },
              teksnya: 'K I R I M',
            ),
          ],
        ),
      ),
    );
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

  Future getJenisLemburKhusus() async {
    final result = await pindahPageCupertinoResult(context, PencarianParent(tipe: "jenisLemburKhusus"));
    

    if (result != null) {
      if (mounted)
        setState(() {
          jenisLemburKhususController.text = result;
        });
    }
  }

  Future save() async {
    BotToast.showLoading(
        clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'nama_lengkap': data['karyawan']['nama_lengkap'].toString(),
      'user_id_penerima':
          data['karyawan']['jabatan']['atasan_1']['user']['id_user'].toString(),
      'nama_zona': data['karyawan']['zona']['nama_zona'].toString(),
      'tgl_lembur_khusus': dateController.text,
      'jenis_lembur_khusus' : jenisLemburKhususController.text,
      'mulai' : timeMulaiController.text,
      'selesai' : timeSelesaiController.text,
      'detail_lembur_khusus': deskripsiController.text,
    };

    print(body);
    await ApiController().lemburkhususSubmit(body).then((response) {
      if (response.data['success']){
        BotToast.closeAllLoading();
        Navigator.pop(context);
        BotToast.showText(
          text: response.data['message'].toString(),
          crossPage: true,
          textStyle: TextStyle(fontSize: 14, color: Colors.white),
          contentColor: Colors.green
      );
      }else{
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

  Future init() async {
    await ApiController().getUser().then((value) {
      if (mounted)
        setState(() {
          data = value.data;
          print("data=$data");
        });
    });
  }
}

class BoxDeskripsi extends StatelessWidget {
  const BoxDeskripsi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 5,
              color: Colors.grey.shade400)
        ],
      ),
      width: lebarlayar,
      padding: EdgeInsets.symmetric(
          horizontal: marginhorizontal, vertical: tinggilayar / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deskripsi"),
          SizedBox(
            height: tinggilayar / 50,
          ),
          TextFormField(
            maxLines: 6,
            decoration: InputDecoration(
              fillColor: Colors.grey[200],
              hintText: "Deskripsi Disini...",
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
