import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/image/image_helper.dart';

class PickImgBottomSheetDialog extends StatelessWidget {
  final int? fileSize;

  const PickImgBottomSheetDialog({Key? key, this.fileSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.camera_fill),
            title: const Text('Camera'),
            onTap: () => _onOpenCamera(context),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
            title: const Text('Anh'),
            onTap: () => _onOpenGallery(context),
          ),
        ],
      ),
    );
  }

  void _onOpenCamera(BuildContext context) async {
    final res = await ImageUtils.selectImage(source: ImageSource.camera);
    Navigator.pop(context, res ?? '');
  }

  void _onOpenGallery(BuildContext context) async {
    final res = await ImageUtils.selectImage(
        maxSizeFile: fileSize, source: ImageSource.gallery);
    Navigator.pop(context, res ?? '');
  }
}
