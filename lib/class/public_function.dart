
import 'dart:convert';
import 'dart:io';

class PublicFunction{
    Future<String> convertImageToBase64(File file) async {
        List<int> imageBytes = file.readAsBytesSync();
        String photoBase64 = base64Encode(imageBytes);

        return photoBase64;
    }
}