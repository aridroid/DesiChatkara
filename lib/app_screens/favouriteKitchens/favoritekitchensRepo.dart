
import 'package:desichatkara/helper/api_base_helper.dart';

import 'favouriteKitchensModel.dart';

class FavoriteKitchenRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<FavoritekitchensModel> getAllFavourite(String token) async {

    final response = await _helper.getWithHeader("wishlist", "Bearer $token");
    return FavoritekitchensModel.fromJson(response);
  }
}