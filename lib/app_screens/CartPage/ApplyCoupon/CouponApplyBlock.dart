//CouponApplyBlock

import 'dart:async';

import 'package:desichatkara/helper/api_response.dart';

import 'CouponApplyModel.dart';
import 'CouponCodeRepository.dart';

class CouponApplyBloc {

  CouponCodeRepository _couponCodeRepository;

  StreamController _couponApplyController;

  StreamSink<ApiResponse<CouponApplyModel>> get couponApplySink =>
      _couponApplyController.sink;

  Stream<ApiResponse<CouponApplyModel>> get couponApplyStream =>
      _couponApplyController.stream;


  CouponApplyBloc() {
    _couponApplyController = StreamController<ApiResponse<CouponApplyModel>>();
    _couponCodeRepository = CouponCodeRepository();
  }

  couponApply(Map body, String token) async {
    couponApplySink.add(ApiResponse.loading("Submitting",));
    try {
      CouponApplyModel response = await _couponCodeRepository.couponApply(body,token);
      couponApplySink.add(ApiResponse.completed(response));
    } catch (e) {
      couponApplySink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _couponApplyController?.close();
    couponApplySink?.close();
  }
}