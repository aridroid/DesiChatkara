

import 'package:desichatkara/app_screens/walletScreen/model/walletAddMoneyModel.dart';
import 'package:desichatkara/app_screens/walletScreen/model/walletBalanceModel.dart';
import 'package:desichatkara/app_screens/walletScreen/model/walletTransactionModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class WalletRepository{

  ApiBaseHelper _apiBaseHelper=new ApiBaseHelper();

  Future<WalletBalanceModel> walletBalance(Map _body, String token) async {
    final response= await _apiBaseHelper.postWithHeader("wallet/get/balance", _body, "Bearer $token");
    return WalletBalanceModel.fromJson(response);
  }
  Future<WalletAddMoneyModel> walletAddMoney(Map _body, String token) async {
    final response= await _apiBaseHelper.postWithHeader("wallet/add/amount", _body, "Bearer $token");
    return WalletAddMoneyModel.fromJson(response);
  }
  Future<WalletTransactionModel> walletTransactionsData(Map _body, String token) async {
    final response= await _apiBaseHelper.postWithHeader("wallet/transaction/history", _body, "Bearer $token");
    return WalletTransactionModel.fromJson(response);
  }
}