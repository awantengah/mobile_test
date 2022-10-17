import 'package:get/get.dart';
import 'package:mobile_prog_test_2/app/modules/home/models/imgflip_model.dart' as imgflip_model;
import 'package:mobile_prog_test_2/app/modules/home/repository/imgflip_repository.dart';

class HomeController extends GetxController {
  List<imgflip_model.Memes> listMeme = [];

  @override
  void onInit() {
    super.onInit();

    getListMeme();
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
