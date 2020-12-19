import 'dart:async';

import 'package:desichatkara/app_screens/CartPage/model/cartItemsUpdateModel.dart';
import 'package:desichatkara/app_screens/CartPage/repository/cartRepository.dart';
import 'package:desichatkara/helper/api_response.dart';


class CartItemsUpdateBloc {

  CartRepository _cartRepository;

  StreamController _cartItemsUpdateController;

  StreamSink<ApiResponse<CartItemsUpdateModel>> get cartItemsUpdateSink =>
      _cartItemsUpdateController.sink;

  Stream<ApiResponse<CartItemsUpdateModel>> get cartItemsUpdateStream =>
      _cartItemsUpdateController.stream;


  CartItemsUpdateBloc() {
    _cartItemsUpdateController = StreamController<ApiResponse<CartItemsUpdateModel>>.broadcast();
    _cartRepository = CartRepository();
  }

  cartItemsUpdate(Map body) async {
    cartItemsUpdateSink.add(ApiResponse.loading("Submitting",));
    try {
      CartItemsUpdateModel response = await _cartRepository.cartItemsUpdate(body);
      cartItemsUpdateSink.add(ApiResponse.completed(response));
    } catch (e) {
      cartItemsUpdateSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _cartItemsUpdateController?.close();
    cartItemsUpdateSink?.close();
  }
}