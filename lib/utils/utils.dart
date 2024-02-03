import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try{
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if(files != null && files.files.isNotEmpty) {
      for(int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
      print(images);
      print("111111111111111111111111111111111111111111111");
    }
  } catch (e) {
    debugPrint(e.toString());
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }
  return images;

}