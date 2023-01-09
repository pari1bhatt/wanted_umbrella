import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String? downloadsPath;

  static showSnackBar(BuildContext context, String msg, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  static String? validateText(String? text) {
    if (text == null || text.isEmpty || text.length < 2) {
      return 'Enter characters only';
    }
    return null;
  }

  static validateEmail(String text) {
    final bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text);
    return !emailValid;
  }

  static validatePassword(String text) {
    bool passValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(text);
    print("valid: ${passValid}");
    return !passValid;
  }

  static Future pickImage() async {
    final _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    File? file = File(pickedImage!.path);
    return file;
  }

  static Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf', 'docx', 'png']);
    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    } else {
      // User canceled the picker
      return null;
    }
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Container(
              decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(child: CircularProgressIndicator()));
        });
  }

  static Future openUrl(String? url) async {
    if (!await launchUrl(Uri.parse(url ?? ''),mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  static setPath() async {
    Directory _path = await getApplicationDocumentsDirectory();
    String _localPath = _path.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    downloadsPath = _localPath;
  }
}
