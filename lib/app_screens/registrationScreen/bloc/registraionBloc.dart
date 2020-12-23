import 'dart:async';

import 'package:desichatkara/app_screens/registrationScreen/model/registrationModel.dart';
import 'package:desichatkara/app_screens/registrationScreen/repository/registrationRepository.dart';
import 'package:desichatkara/helper/api_response.dart';

class RegistraionBloc {

  RegistrationRepository _registrationRepository;

  StreamController _registrationController;

  StreamSink<ApiResponse<RegistrationModel>> get registrationSink =>
      _registrationController.sink;

  Stream<ApiResponse<RegistrationModel>> get registrationStream =>
      _registrationController.stream;


  RegistraionBloc() {
    _registrationController = StreamController<ApiResponse<RegistrationModel>>();
    _registrationRepository = RegistrationRepository();
  }

  Register(Map body) async {
    registrationSink.add(ApiResponse.loading("Submitting",));
    try {
      RegistrationModel response = await _registrationRepository.registration(body);
      registrationSink.add(ApiResponse.completed(response));
    } catch (e) {
      registrationSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }


  dispose() {
    _registrationController?.close();
    registrationSink?.close();
  }
}
