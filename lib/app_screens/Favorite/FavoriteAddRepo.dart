import '../../helper/api_base_helper.dart';
import 'FavoriteAddModel.dart';

class FavoriteAddRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<FavoriteAddModel> favoriteadd(Map body,String token) async {
    final response = await _helper.postWithHeader('wishlist',body,"Bearer $token");
    return FavoriteAddModel.fromJson(response);
  }


}