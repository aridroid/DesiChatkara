
import 'package:desichatkara/helper/api_base_helper.dart';

import 'OrderDetailsModel.dart';


class OrderDetailsRepositry {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<OrderDetailsModel> getOrderDetails(body) async {

   final response = await _helper.post("order/details",body);
    return OrderDetailsModel.fromJson(response);
  }
}