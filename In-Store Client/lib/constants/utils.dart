import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

void showSnackBar(BuildContext context, String message,
    {Color color = Colors.black87}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
  ));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      images = result.paths.map((path) => File(path!)).toList();
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
Future<File?> pickImage() async {
  File? image;
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      image = File(result.files.single.path!);
    }
    else{
      image = null;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}
