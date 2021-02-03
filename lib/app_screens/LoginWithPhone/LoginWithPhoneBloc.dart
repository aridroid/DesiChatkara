import 'dart:async';
import 'package:desichatkara/helper/api_response.dart';

import 'LoginWithPhoneModel.dart';
import 'LoginWithPhoneRepositry.dart';

class LoginWithPhoneBloc {
  LoginPhoneRepository  _loginPhoneRepository;

  StreamController _userLoginController;

  StreamSink<ApiResponse<LoginWithPhoneModel>> get userLoginSink =>
      _userLoginController.sink;

  Stream<ApiResponse<LoginWithPhoneModel>> get userLoginStream =>
      _userLoginController.stream;


  LoginWithPhoneBloc() {
    _userLoginController = StreamController<ApiResponse<LoginWithPhoneModel>>.broadcast();
    _loginPhoneRepository = LoginPhoneRepository();
    // getOtp();
  }
  userLogin(Map body) async {
    userLoginSink.add(ApiResponse.loading("Fetching",));

    try {
      LoginWithPhoneModel response = await _loginPhoneRepository.userLogin(body);
      userLoginSink.add(ApiResponse.completed(response));
    } catch (e) {
      userLoginSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

}