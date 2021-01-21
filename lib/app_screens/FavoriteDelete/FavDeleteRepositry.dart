import '../../helper/api_base_helper.dart';
import 'FavDeleteModel.dart';

class FavoriteDeleteRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<FavDeleteModel> favoritedelete(Map body,String token) async {
    final response = await _helper.postWithHeader('deletewishlist',body,"Bearer $token");
    return FavDeleteModel.fromJson(response);
  }


}