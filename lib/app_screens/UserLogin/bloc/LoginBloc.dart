import 'dart:async';

import 'package:desichatkara/app_screens/UserLogin/model/LoginModel.dart';
import 'package:desichatkara/app_screens/UserLogin/repository/LoginRepo.dart';
import 'package:desichatkara/helper/api_response.dart';

class LoginBloc {
  UserLoginRepository  _userLoginRepository;

  StreamController _userLoginController;

  StreamSink<ApiResponse<UserLoginResponseModel>> get userLoginSink =>
      _userLoginController.sink;

  Stream<ApiResponse<UserLoginResponseModel>> get userLoginStream =>
     _userLoginController.stream;


  LoginBloc() {
     _userLoginController = StreamController<ApiResponse<UserLoginResponseModel>>.broadcast();
//    _docprofileController = StreamController<ApiResponse<DocProfileModel>>();
    _userLoginRepository = UserLoginRepository();
    // getOtp();
  }
  userLogin(Map body) async {
    userLoginSink.add(ApiResponse.loading("Fetching",));
    
    try {
      UserLoginResponseModel response = await _userLoginRepository.userLogin(body);
      userLoginSink.add(ApiResponse.completed(response));
    } catch (e) {
      userLoginSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

}