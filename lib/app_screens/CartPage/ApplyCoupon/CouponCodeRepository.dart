

import 'package:desichatkara/helper/api_base_helper.dart';

import 'CouponApplyModel.dart';

class CouponCodeRepository{
  ApiBaseHelper _apiBaseHelper = new ApiBaseHelper();

  Future<CouponApplyModel> couponApply(Map body,String token) async{
    // Map body={};
    final response= await _apiBaseHelper.postWithHeader("apply/coupon", body,"Bearer $token");
    return CouponApplyModel.fromJson(response);
  }
}