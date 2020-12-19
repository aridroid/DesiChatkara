import 'package:desichatkara/app_screens/KitchenDetails/model/foodDetailsModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class FoodHomeRepository{
  ApiBaseHelper _helper=new ApiBaseHelper();


  Future<FoodDetailsModel> foodDetails(_categoryId,_vendorId,_cartId) async{

    final response = await _helper.get("productlist?category_id=$_categoryId&vendor_id=$_vendorId&cartid=$_cartId");
    return FoodDetailsModel.fromJson(response);
  }


}