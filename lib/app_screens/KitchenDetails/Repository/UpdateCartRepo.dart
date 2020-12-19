import 'package:desichatkara/app_screens/KitchenDetails/model/UpdateCartModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class UpdateCartRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UpdateCartResponseModel> updateCart(body) async {
   
    final response = await _helper.post("cart/update",body);
    return UpdateCartResponseModel.fromJson(response);
  }
}