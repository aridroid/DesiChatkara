import 'dart:developer';

import 'package:desichatkara/app_screens/KitchenDetails/model/KitchenDetailsModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class KitchenDetailRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<KitchenDetailsResponseModel> getMenu() async {
   
    final response = await _helper.get("productlist?category_id=2&vendor_id=81");
    return KitchenDetailsResponseModel.fromJson(response);
  }

  Future<KitchenDetailsResponseModel> getMenuWithCartId(String cartid) async {
   
    final response = await _helper.get("productlist?category_id=2&vendor_id=81&cartid="+cartid);
    log(response);
    return KitchenDetailsResponseModel.fromJson(response);
  }
}