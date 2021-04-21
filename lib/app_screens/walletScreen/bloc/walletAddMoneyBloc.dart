import 'dart:async';

import 'package:desichatkara/app_screens/walletScreen/model/walletAddMoneyModel.dart';
import 'package:desichatkara/app_screens/walletScreen/repository/walletRepository.dart';
import 'package:desichatkara/helper/api_response.dart';


class WalletMoneyAddBloc {

  WalletRepository _walletRepository;

  StreamController _walletMoneyAddController;

  StreamSink<ApiResponse<WalletAddMoneyModel>> get walletMoneyAddSink =>
      _walletMoneyAddController.sink;

  Stream<ApiResponse<WalletAddMoneyModel>> get walletMoneyAddStream =>
      _walletMoneyAddController.stream;


  WalletMoneyAddBloc() {
    _walletMoneyAddController = StreamController<ApiResponse<WalletAddMoneyModel>>.broadcast();
    _walletRepository = WalletRepository();
  }

  walletMoneyAdd(Map _body,String _token) async {
    walletMoneyAddSink.add(ApiResponse.loading("Submitting",));
    try {
      WalletAddMoneyModel response = await _walletRepository.walletAddMoney(_body,_token);
      walletMoneyAddSink.add(ApiResponse.completed(response));
    } catch (e) {
      walletMoneyAddSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _walletMoneyAddController?.close();
    walletMoneyAddSink?.close();
  }
}