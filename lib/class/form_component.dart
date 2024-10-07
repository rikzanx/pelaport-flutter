import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelaport/constant.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool isRequired,
      isReadonly,
      isDropdown,
      isLongText,
      isDatePicker,
      isObsecureText;
  final Function()? onTap;

  const CustomTextFormField(
      {Key? key,
      @required this.controller,
      @required this.placeholder,
      this.isRequired = false,
      this.isReadonly = false,
      this.isDropdown = false,
      this.onTap,
      this.isLongText = false,
      this.isDatePicker = false,
      this.isObsecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: isDropdown || isDatePicker ? onTap : null,
      readOnly: isDropdown || isReadonly ? true : false,
      controller: controller,
      validator: (value) {
        if (isRequired) if (value == null || value.isEmpty) {
          return 'Tidak boleh kosong';
        }

        return null;
      },
      minLines: isLongText ? 4 : null,
      // obscureText: isObsecureText,
      maxLines: isLongText ? 4 : null,
      decoration: InputDecoration(
        suffixIcon: isDropdown
            ? Icon(CupertinoIcons.arrow_right)
            : isDatePicker
                ? Icon(CupertinoIcons.calendar_today)
                : null,
        hintText: placeholder,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onClick;
  final String? teksnya;
  final Color? warna;
  const PrimaryButton(
      {Key? key, required this.warna, this.onClick, this.teksnya})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: tinggilayar / 15,
      padding: EdgeInsets.symmetric(horizontal: marginhorizontal),
      margin: EdgeInsets.only(bottom: tinggilayar / 20),
      child: GestureDetector(
        onTap: onClick,
        child: Material(
          color: primarycolor,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              teksnya!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: tinggilayar / lebarlayar * 7),
            ),
          ),
        ),
      ),
    );
  }
}
