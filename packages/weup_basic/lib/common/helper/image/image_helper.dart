import 'dart:io' as io;
import 'package:weup_basic/common/core/sys/permission_config.dart';
import 'package:weup_basic/common/helper/file_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../view_utils.dart';
import 'img_crop.dart';

enum PickImageType {
  image,
  video,
  audio,
  all,
}

class ImageUtils {
  ImageUtils._();

  static final _picker = ImagePicker();

  static Future<String?>? selectImage({
    bool hasCrop = false,
    double? width,
    double? height,
    int? imageQuality,
    ImageSource source = ImageSource.gallery,
    int? maxSizeFile,
  }) async {
    bool request = await PermissionConfig.instance.request(
      permission:
          source == ImageSource.camera ? Permission.camera : Permission.photos,
      title: 'Thông báo',
      content:
          'Bạn cần cấp quyền truy cập vào ${source == ImageSource.camera ? 'Camera' : 'Thư viện'}',
    );
    if (!request) return '';

    final XFile? _image = await _picker.pickImage(
      source: source,
      maxWidth: width,
      maxHeight: height,
      imageQuality: imageQuality,
    );
    if (_image == null) return null;

    final rawFile = io.File(_image.path);
    bool isMax = await FileUtils().checkSize(rawFile, size: maxSizeFile);
    if (isMax) {
      ViewUtils.toast('Ảnh tải lên vượt quá $maxSizeFile MB',
          mode: ToastMode.error);
      return null;
    }
    if (!hasCrop) return _image.path;
    final _path = await ImgCrop.instance().cropFile(_image.path);
    return _path!;
  }

  static Future<String>? pick(
      {ImageSource source = ImageSource.camera,
      CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    bool request = await PermissionConfig.instance.request(
        permission: Permission.camera,
        title: 'Thông báo',
        content:
            'Bạn cần cấp quyền truy cập vào ${source == ImageSource.camera ? 'Camera' : 'Thư viện'}');
    if (!request) return '';
    final XFile? _file = await _picker.pickVideo(
        source: source, preferredCameraDevice: preferredCameraDevice);
    if (_file == null) return '';
    return _file.path;
  }
}
