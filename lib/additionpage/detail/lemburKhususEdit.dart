import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/additionpage/detail/presensi.dart';
import 'package:pelaport/apicontroller.dart';
import 'package:pelaport/class/form_component.dart';
import 'package:pelaport/constant.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pelaport/function/route.dart';
import 'package:pelaport/views/laporan/pencarian_parent.dart';


class LemburKhususEdit extends StatefulWidget {
  final String jenisLemburKhusus;
  final String tglLemburKhusus;
  final String mulai;
  final String selesai;
  final String id_lembur_khusus;

  const LemburKhususEdit({Key? key,
                    required this.jenisLemburKhusus,
                    required this.mulai, 
                    required this.selesai, 
                    required this.tglLemburKhusus,
                    required this.id_lembur_khusus
                    }) : super(key: key);

  @override
  _LemburKhususEditState createState() => _LemburKhususEditState();
}

class _LemburKhususEditState extends State<LemburKhususEdit> {
  var dateController = TextEditingController();
  var deskripsiController = TextEditingController();
  var timeMulaiController = TextEditingController();
  var timeSelesaiController = TextEditingController();
  var jenisLemburController = TextEditingController();
  String sisaLembur = "0";

  int _currentHorizontalIntValue = 1;

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

  Future timemulai() async{
    final TimeOfDay? timeMulai = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
      );

    if(timeMulai != null){
      timeMulaiController.text = timeMulai.format(context);
      print(timeMulai.format(context));
    }
  }

  Future timeselesai() async{
    final TimeOfDay? timeSelesai = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
      );

    if(timeSelesai != null){
      timeSelesaiController.text = timeSelesai.format(context);
      print(timeSelesai.toString());
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
          "Edit Form Lembur Khusus",
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
            SizedBox(
                height: tinggilayar / 40,
            ),
            SizedBox(
              height: 25,
            ),
            myContainer(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Jenis Lembur"),
                      SizedBox(
                        height: 4,
                      ),
                      CustomTextFormField(
                          onTap: getJenisLembur,
                          isDropdown: true,
                          isRequired: true,
                          controller: jenisLemburController,
                          placeholder: "Jenis"),
                    ]
            )),
            SizedBox(
              height: 16,
            ),
            myContainer(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label("Tanggal Lembur"),
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
                label("Jam mulai lembur"),
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
                label("Jam selesai lembur"),
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

  Future getJenisLembur() async {
    final result = await pindahPageCupertinoResult(context, PencarianParent(tipe: "jenisLembur"));
    

    if (result != null) {
      if (mounted)
        setState(() {
          jenisLemburController.text = result;
        });
    }
  }

  Future save() async {
    BotToast.showLoading(
        clickClose: false, allowClick: false, crossPage: false);

    Map<String, String> body = {
      'id_lembur_khusus' : widget.id_lembur_khusus,
      'tgl_lembur_khusus': dateController.text,
      'jenis_lembur_khusus' : jenisLemburController.text,
      'mulai' : timeMulaiController.text,
      'selesai' : timeSelesaiController.text,
    };

    print(body);
    await ApiController().lemburkhususEdit(body).then((response) {
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
    jenisLemburController = TextEditingController(text: widget.jenisLemburKhusus);
    dateController = TextEditingController(text: widget.tglLemburKhusus);
    timeMulaiController  = TextEditingController(text: widget.mulai); 
    timeSelesaiController  = TextEditingController(text: widget.selesai); 
    await ApiController().getUser().then((value) {
      if (mounted
      )
        setState(() {
          data = value.data;
          sisaLembur = data["sisa_lembur"].toString();
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
