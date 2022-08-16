import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImgCrop {
  ImgCrop._internal();

  static ImgCrop? _instance;

  factory ImgCrop.instance() => _instance ??= ImgCrop._internal();

  Future<String>? cropFile(String imgPath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imgPath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile!.path;
  }
}

class CropUISetting {
  final String title;

  CropUISetting(this.title);
}
