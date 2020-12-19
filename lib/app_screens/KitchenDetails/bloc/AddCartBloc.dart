import 'dart:async';

import 'package:desichatkara/app_screens/KitchenDetails/Repository/AddCartRepo.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/AddCartModel.dart';
import 'package:desichatkara/helper/api_response.dart';

class AddCartBloc {
  AddCartRepository  _addCartRepository;

  // ignore: close_sinks
  StreamController _addCartController;

  StreamSink<ApiResponse<AddCartResponseModel>> get addCartSink =>
      _addCartController.sink;

  Stream<ApiResponse<AddCartResponseModel>> get addCartStream =>
     _addCartController.stream;


  AddCartBloc() {
     _addCartController = StreamController<ApiResponse<AddCartResponseModel>>.broadcast();

    _addCartRepository = AddCartRepository();
    // getOtp();
  }
  addCart(Map body) async {
    addCartSink.add(ApiResponse.loading("Fetching",));
    
    try {
      AddCartResponseModel response = await _addCartRepository.addCart(body);
      addCartSink.add(ApiResponse.completed(response));
    } catch (e) {
      addCartSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

}