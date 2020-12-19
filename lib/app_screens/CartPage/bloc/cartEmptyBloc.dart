import 'dart:async';

import 'package:desichatkara/app_screens/CartPage/model/cartItemsEmptyModel.dart';
import 'package:desichatkara/app_screens/CartPage/repository/cartRepository.dart';
import 'package:desichatkara/helper/api_response.dart';


class CartEmptyBloc {

  CartRepository _cartRepository;

  StreamController _cartItemsEmptyController;

  StreamSink<ApiResponse<CartItemsEmptyModel>> get cartItemsEmptySink =>
      _cartItemsEmptyController.sink;

  Stream<ApiResponse<CartItemsEmptyModel>> get cartItemsEmptyStream =>
      _cartItemsEmptyController.stream;


  CartEmptyBloc() {
    _cartItemsEmptyController = StreamController<ApiResponse<CartItemsEmptyModel>>();
    _cartRepository = CartRepository();
  }

  cartItemsEmpty(Map body) async {
    cartItemsEmptySink.add(ApiResponse.loading("Submitting",));
    try {
      CartItemsEmptyModel response = await _cartRepository.cartItemsEmpty(body);
      cartItemsEmptySink.add(ApiResponse.completed(response));
    } catch (e) {
      cartItemsEmptySink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _cartItemsEmptyController?.close();
    cartItemsEmptySink?.close();
  }
}