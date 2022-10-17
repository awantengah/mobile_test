import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_watermark/image_watermark.dart';
import 'package:mobile_prog_test_2/app/modules/home/models/imgflip_model.dart' as imgflip_model;

class DetailController extends GetxController {
  late imgflip_model.Memes? dataMeme;
  late TextEditingController addTextController;

  final ImagePicker imagePicker = ImagePicker();

  dynamic mainImageBytes;
  dynamic imgBytes;
  dynamic watermarkedImageBytes;

  bool isAddImage = false;
  bool isAddText = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['data'] != "") {
      dataMeme = Get.arguments['data'];
      getMainImageBytes(dataMeme);
    }
    addTextController = TextEditingController();
  }

  getMainImageBytes(data) async {
    mainImageBytes = (await NetworkAssetBundle(Uri.parse(data?.url ?? '')).load(data?.url ?? '')).buffer.asUint8List();
  }

  addImageWatermark() async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      var a = await image.readAsBytes();
      imgBytes = Uint8List.fromList(a);

      watermarkedImageBytes = await image_watermark.addImageWatermark(
        mainImageBytes,
        imgBytes,
        imgWidth: 200,
        imgHeight: 200,
        dstX: 10,
        dstY: 10,
      );

      mainImageBytes = watermarkedImageBytes;
      isAddImage = true;
      update();
    }
  }

  addTextWatermark(val) async {
    watermarkedImageBytes = await image_watermark.addTextWatermarkCentered(
      mainImageBytes,
      val,
    );
    mainImageBytes = watermarkedImageBytes;
    isAddText = true;
    update();
  }
}
