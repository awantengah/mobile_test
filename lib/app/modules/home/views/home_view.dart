import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:mobile_prog_test_2/app/core/components/network_image_component.dart';
import 'package:mobile_prog_test_2/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MimGenerator'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green.shade900,
      ),
      body: EasyRefresh(
        controller: controller.easyRefreshController,
        header: const MaterialHeader(),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          controller.clearListMeme();
          controller.getListMeme();
          controller.easyRefreshController.finishRefresh();
          controller.easyRefreshController.resetFooter();
        },
        notLoadFooter: const NotLoadFooter(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              var list = controller.listMeme;
              var listLength = list.length;

              if (listLength > 0) {
                return AlignedGridView.count(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemCount: listLength,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.detail,
                          arguments: {
                            'data': list[index],
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageComponent(
                          image: list[index].url!,
                          height: 125,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
