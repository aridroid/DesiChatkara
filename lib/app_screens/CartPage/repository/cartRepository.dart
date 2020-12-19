
import 'package:desichatkara/app_screens/CartPage/model/cartItemsAddModel.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsDetailsModel.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsEmptyModel.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsUpdateModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class CartRepository{
  ApiBaseHelper _apiBaseHelper = new ApiBaseHelper();
  
  Future<CartItemsAddModel> cartItemsAdd(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("cart/add", body);
    return CartItemsAddModel.fromJson(response);
  }

  Future<CartItemsUpdateModel> cartItemsUpdate(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("cart/update", body);
    return CartItemsUpdateModel.fromJson(response);
  }

  Future<CartItemsDetailsModel> cartItemsDetails(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("cart/details", body);
    return CartItemsDetailsModel.fromJson(response);
  }

  Future<CartItemsEmptyModel> cartItemsEmpty(body) async{
    // Map body={};
    final response= await _apiBaseHelper.post("cart/empty", body);
    return CartItemsEmptyModel.fromJson(response);
  }
}