
import 'package:desichatkara/app_screens/orderDetails_screen/model/orderDetailsModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class OrderDetailsRepository{
  ApiBaseHelper _apiBaseHelper=new ApiBaseHelper();

  Future<OrderDetailsModel> orderDetails(_body,_token) async{

    final response = await _apiBaseHelper.postWithHeader("user/order/list", _body,"Bearer $_token");
    return OrderDetailsModel.fromJson(response);
  }
}