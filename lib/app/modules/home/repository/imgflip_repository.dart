import 'package:mobile_prog_test_2/app/core/repository/repository.dart';
import 'package:mobile_prog_test_2/app/modules/home/models/imgflip_model.dart';

class ImgflipRepository extends Repository {
  Future<ImgflipModel?> getListMeme() async {
    var url = 'https://api.imgflip.com/get_memes';
    var data = await getResponse(url);
    if (data != null) {
      return ImgflipModel.fromJson(data);
    }
    return data;
  }
}