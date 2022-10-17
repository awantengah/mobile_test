import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:mobile_prog_test_2/app/modules/home/models/imgflip_model.dart' as imgflip_model;
import 'package:mobile_prog_test_2/app/modules/home/repository/imgflip_repository.dart';

class HomeController extends GetxController {
  late EasyRefreshController easyRefreshController;
  List<imgflip_model.Memes> listMeme = [];

  @override
  void onInit() {
    super.onInit();
    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
    );
    getListMeme();
  }

  void clearListMeme() {
    listMeme = [];
    update();
  }

  void getListMeme() async {
    try {
      var response = await ImgflipRepository().getListMeme();
      if (response != null) {
        listMeme = response.data!.memes ?? [];
      }
    } finally {
      update();
    }
  }
}
