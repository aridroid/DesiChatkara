import 'package:desichatkara/app_screens/CartPage/model/ShowCartItemModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class ShowCartItemRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ShowCartItemResponseModel> showCartItem(body) async {
   
    final response = await _helper.post("cart/details",body);
    return ShowCartItemResponseModel.fromJson(response);
  }
}