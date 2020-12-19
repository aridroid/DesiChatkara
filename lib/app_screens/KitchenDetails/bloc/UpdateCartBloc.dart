import 'dart:async';

//import 'package:desichatkara/app_screens/KitchenDetails/Repository/AddCartRepo.dart';
import 'package:desichatkara/app_screens/KitchenDetails/Repository/UpdateCartRepo.dart';
//import 'package:desichatkara/app_screens/KitchenDetails/model/AddCartModel.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/UpdateCartModel.dart';
import 'package:desichatkara/helper/api_response.dart';

class UpdateCartBloc {
  UpdateCartRepository  _updateCartRepository;

  StreamController _updateCartController;

  StreamSink<ApiResponse<UpdateCartResponseModel>> get updateCartSink =>
      _updateCartController.sink;

  Stream<ApiResponse<UpdateCartResponseModel>> get updateCartStream =>
     _updateCartController.stream;


  UpdateCartBloc() {
     _updateCartController = StreamController<ApiResponse<UpdateCartResponseModel>>.broadcast();
//    _docprofileController = StreamController<ApiResponse<DocProfileModel>>();
    _updateCartRepository = UpdateCartRepository();
    // getOtp();
  }
  updateCart(Map body) async {
    updateCartSink.add(ApiResponse.loading("Fetching",));
    
    try {
      UpdateCartResponseModel response = await _updateCartRepository.updateCart(body);
      updateCartSink.add(ApiResponse.completed(response));
    } catch (e) {
      updateCartSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

}