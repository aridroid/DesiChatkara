import 'package:desichatkara/app_screens/KitchenDetails/model/AddCartModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class AddCartRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AddCartResponseModel> addCart(body) async {
   
    final response = await _helper.post("cart/add",body);
    return AddCartResponseModel.fromJson(response);
  }
}