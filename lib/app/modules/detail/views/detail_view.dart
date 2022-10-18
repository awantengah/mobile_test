import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_prog_test_2/app/core/components/network_image_component.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MimGenerator'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green.shade900,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GetBuilder<DetailController>(
                builder: (controller) {
                  if (controller.watermarkedImageBytes == null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetworkImageComponent(
                        image: controller.dataMeme?.url ?? '',
                      ),
                    );
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(controller.watermarkedImageBytes),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<DetailController>(
                          builder: (controller) {
                            if (controller.isAddImage != true) {
                              return Flexible(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      'Add Logo',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Future.delayed(const Duration(milliseconds: 500));
                                        await controller.addImageWatermark();
                                      },
                                      child: const Icon(
                                        Icons.image_outlined,
                                        size: 36,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        GetBuilder<DetailController>(
                          builder: (controller) {
                            if (controller.isAddText != true) {
                              return Flexible(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Add Text',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextField(
                                      controller: controller.addTextController,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                      ),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        helperText: '',
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      onSubmitted: (val) async {
                                        await Future.delayed(const Duration(milliseconds: 500));
                                        await controller.addTextWatermark(val);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                    GetBuilder<DetailController>(
                      builder: (controller) {
                        if (controller.isAddImage == true && controller.isAddText == true && controller.isBtnSharePress == false) {
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await controller.checkPermission();
                                    var status = await controller.saveWatermarkedImageToLocal();
                                    Get.snackbar(
                                      "Sukses",
                                      status == true ? 'Gambar berhasil disimpan' : 'Gambar gagal di simpan',
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.blue.shade300,
                                      borderRadius: 10,
                                      margin: EdgeInsets.only(
                                        bottom: Get.height * .1,
                                        left: 10,
                                        right: 10,
                                      ),
                                      colorText: Colors.white,
                                      duration: const Duration(milliseconds: 1500),
                                      isDismissible: true,
                                      dismissDirection: DismissDirection.horizontal,
                                      forwardAnimationCurve: Curves.easeOutBack,
                                    );
                                  },
                                  child: Text(
                                    'Simpan',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.pressBtnShare();
                                  },
                                  child: Text(
                                    'Share',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (controller.isBtnSharePress == true) {
                          return Column(
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.shareToSocialMedia(ShareTo.facebook, context);
                                    Get.snackbar(
                                      "Failed",
                                      '-',
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.blue.shade300,
                                      borderRadius: 10,
                                      margin: EdgeInsets.only(
                                        bottom: Get.height * .1,
                                        left: 10,
                                        right: 10,
                                      ),
                                      colorText: Colors.white,
                                      duration: const Duration(milliseconds: 1500),
                                      isDismissible: true,
                                      dismissDirection: DismissDirection.horizontal,
                                      forwardAnimationCurve: Curves.easeOutBack,
                                    );
                                  },
                                  child: Text(
                                    'Share to FB',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.shareToSocialMedia(ShareTo.twitter, context);
                                    Get.snackbar(
                                      "Failed",
                                      '-',
                                      icon: const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.blue.shade300,
                                      borderRadius: 10,
                                      margin: EdgeInsets.only(
                                        bottom: Get.height * .1,
                                        left: 10,
                                        right: 10,
                                      ),
                                      colorText: Colors.white,
                                      duration: const Duration(milliseconds: 1500),
                                      isDismissible: true,
                                      dismissDirection: DismissDirection.horizontal,
                                      forwardAnimationCurve: Curves.easeOutBack,
                                    );
                                  },
                                  child: Text(
                                    'Share to Twitter',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
