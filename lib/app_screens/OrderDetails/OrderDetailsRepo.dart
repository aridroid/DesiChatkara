
import 'package:desichatkara/helper/api_base_helper.dart';

import 'OrderDetailsModel.dart';


class OrderDetailsRepositry {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<OrderDetailsModel> getOrderDetails(Map body,String token) async {

   final response = await _helper.postWithHeader("order/details", body,"Bearer $token");
    return OrderDetailsModel.fromJson(response);
  }
}